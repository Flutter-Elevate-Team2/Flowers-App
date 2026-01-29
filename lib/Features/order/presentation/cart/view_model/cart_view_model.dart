import 'dart:async';

import 'package:flowers_app/Features/auth/domain/use_cases/valid_token_usecase.dart';
import 'package:flowers_app/Features/order/data/models/cart/cart_request_dto.dart';
import 'package:flowers_app/Features/order/data/models/cart/quantity_request.dart';
import 'package:flowers_app/Features/order/domain/entities/cart/cart_entity.dart';
import 'package:flowers_app/Features/order/domain/entities/cart/cart_response_entity.dart';
import 'package:flowers_app/Features/order/domain/use_cases/cart/add_to_cart_use_case.dart';
import 'package:flowers_app/Features/order/domain/use_cases/cart/delete_cart_item_use_case.dart';
import 'package:flowers_app/Features/order/domain/use_cases/cart/get_cart_use_case.dart';
import 'package:flowers_app/Features/order/domain/use_cases/cart/update_cart_item_use_case.dart';
import 'package:flowers_app/Features/order/presentation/cart/view_model/cart_events.dart';
import 'package:flowers_app/Features/order/presentation/cart/view_model/cart_states.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flowers_app/core/controller/session_controller.dart';
import 'package:flowers_app/core/utils/debouncer/debouncer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class CartViewModel extends Cubit<CartStates> {
  final GetCartUseCase _getCartUseCase;
  final AddToCartUseCase _addToCartUseCase;
  final UpdateCartItemUseCase _updateCartItemUseCase;
  final DeleteCartItemUseCase _deleteCartItemUseCase;
  final HasValidTokenUseCase _hasTokenUseCase;
  final SessionController _sessionController;
  final Debouncer _debouncer;
  final Map<String, int> _pendingQuantities = {};

  StreamSubscription? _loginSubscription;
  StreamSubscription? _logoutSubscription;

  CartViewModel(
    this._getCartUseCase,
    this._addToCartUseCase,
    this._updateCartItemUseCase,
    this._deleteCartItemUseCase,
    this._hasTokenUseCase,
    this._sessionController,
    this._debouncer,
  ) : super(const CartStates()) {
    _listenToSession();
  }

  void doIntent(CartEvent event) {
    if (event is GetCartDataEvent) {
      _getCart();
    } else if (event is AddToCartEvent) {
      _addToCart(event.cartRequest);
    } else if (event is UpdateCartItemEvent) {
      _optimisticUpdate(event.itemId, event.quantityRequest.quantity);
    } else if (event is DeleteCartItemEvent) {
      _optimisticUpdate(event.itemId, 0);
    } else if (event is CartLoginHandledEvent) {
      _resetLoginRequired();
    } else if (event is ClearCartEvent) {
      _clearCart();
    }
  }

  void _listenToSession() {
    _loginSubscription = _sessionController.onLogin.listen((_) {
      if (state.requiresLogin) emit(state.copyWith(requiresLogin: false));
      _getCart();
    });

    _logoutSubscription = _sessionController.onLogout.listen((reason) {
      if (reason == SessionEndReason.guest ||
          reason == SessionEndReason.logout) {
        emit(const CartStates(isGuest: true));
      }
    });
  }

  Future<void> _getCart() async {
    if (!await _hasTokenUseCase()) {
      emit(const CartStates(isGuest: true));
      return;
    }

    emit(state.copyWith(isLoading: true, errorMessage: null));

    final response = await _getCartUseCase();

    if (response is SuccessResponse<CartResponseEntity>) {
      emit(
        CartStates.fromCart(response.data).copyWith(
          isLoading: false,
          isGuest: false,
        ),
      );
    } else if (response is ErrorResponse<CartResponseEntity>) {
      emit(
        state.copyWith(isLoading: false, errorMessage: response.errorMessage),
      );
    }
  }

  Future<void> _addToCart(CartRequest request) async {
    if (!await _hasTokenUseCase()) {
      emit(state.copyWith(requiresLogin: true));
      return;
    }

    final product = request.product;
    if (product == null) {
      return;
    }
    final id = product;

    emit(
      state.copyWith(
        updatingItemIds: {...state.updatingItemIds, id},
        optimisticQuantities: {
          ...state.optimisticQuantities,
          id: request.quantity ?? 1,
        },
      ),
    );

    final response = await _addToCartUseCase(request);

    if (response is SuccessResponse<CartResponseEntity>) {
      emit(CartStates.fromCart(response.data));
    } else if (response is ErrorResponse<CartResponseEntity>) {
      _handleError(id, response.errorMessage);
      _stopLoading(id, removeOptimistic: true);
    }
  }

  void _optimisticUpdate(String itemId, int quantity) {
    _pendingQuantities[itemId] = quantity;

    final optimistic = Map<String, int>.from(state.optimisticQuantities)
      ..[itemId] = quantity;
    final updating = {...state.updatingItemIds, itemId};

    emit(
      state.copyWith(
        optimisticQuantities: optimistic,
        updatingItemIds: updating,
      ),
    );

    _debouncer.run(() async {
      if (_pendingQuantities[itemId] != quantity) return;

      if (quantity > 0) {
        await _updateCartItem(itemId, QuantityRequest(quantity: quantity));
      } else {
        await _deleteCartItem(itemId);
      }
    });
  }

  Future<void> _updateCartItem(String itemId, QuantityRequest request) async {
    final response = await _updateCartItemUseCase(itemId, request);

    if (response is SuccessResponse<CartResponseEntity>) {
      emit(CartStates.fromCart(response.data));
    } else if (response is ErrorResponse<CartResponseEntity>) {
      _handleError(itemId, response.errorMessage);
    }

    _pendingQuantities.remove(itemId);
    _stopLoading(itemId, removeOptimistic: true);
  }

  Future<void> _deleteCartItem(String itemId) async {
    final response = await _deleteCartItemUseCase(itemId);
    if (response is SuccessResponse<CartResponseEntity>) {
      emit(CartStates.fromCart(response.data));
    } else if (response is ErrorResponse<CartResponseEntity>) {
      _handleError(itemId, response.errorMessage);
    }

    _pendingQuantities.remove(itemId);
    _stopLoading(itemId, removeOptimistic: true);
  }

  void _stopLoading(String itemId, {bool removeOptimistic = false}) {
    final updating = Set<String>.from(state.updatingItemIds)..remove(itemId);
    final optimistic = removeOptimistic
        ? (Map<String, int>.from(state.optimisticQuantities)..remove(itemId))
        : state.optimisticQuantities;

    emit(
      state.copyWith(
        updatingItemIds: updating,
        optimisticQuantities: optimistic,
      ),
    );
  }

  void _handleError(String itemId, String errorMessage) {
    final optimistic = Map<String, int>.from(state.optimisticQuantities)
      ..remove(itemId);
    final updating = Set<String>.from(state.updatingItemIds)..remove(itemId);

    emit(
      state.copyWith(
        errorMessage: errorMessage,
        lastFailedItemId: itemId,
        optimisticQuantities: optimistic,
        updatingItemIds: updating,
      ),
    );
  }
  void _clearCart() {
    emit(
      CartStates(
        cartData: CartResponseEntity(
          cart: CartEntity(cartItems: []),
          numOfCartItems: 0,
        ),
        isGuest: false,
      ),
    );
  }


  void _resetLoginRequired() {
    if (state.requiresLogin) emit(state.copyWith(requiresLogin: false));
  }

  @override
  Future<void> close() {
    _loginSubscription?.cancel();
    _logoutSubscription?.cancel();
    _debouncer.dispose();
    return super.close();
  }
}
