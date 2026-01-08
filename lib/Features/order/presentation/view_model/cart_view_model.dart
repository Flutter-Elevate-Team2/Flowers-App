import 'package:flowers_app/Features/order/data/models/quantity_request.dart';
import 'package:flowers_app/Features/order/domain/entities/cart_response_entity.dart';
import 'package:flowers_app/Features/order/domain/use_cases/add_to_cart_use_case.dart';
import 'package:flowers_app/Features/order/domain/use_cases/delete_cart_item_use_case.dart';
import 'package:flowers_app/Features/order/domain/use_cases/get_cart_use_case.dart';
import 'package:flowers_app/Features/order/domain/use_cases/update_cart_item_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:flowers_app/Features/order/presentation/view_model/cart_events.dart';
import 'package:flowers_app/Features/order/presentation/view_model/cart_states.dart';

import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flowers_app/Features/order/data/models/cart_request_dto.dart';

@Injectable()
class CartViewModel extends Cubit<CartStates> {
  final GetCartUseCase _getCartUseCase;
  final AddToCartUseCase _addToCartUseCase;
  final UpdateCartItemUseCase _updateCartItemUseCase;
  final DeleteCartItemUseCase _deleteCartItemUseCase;

  CartViewModel(
      this._getCartUseCase,
      this._addToCartUseCase,
      this._updateCartItemUseCase,
      this._deleteCartItemUseCase,
      ) : super(CartStates());

  void doIntent(CartEvent event) {
    if (event is GetCartDataEvent) {
      _getCart();
    } else if (event is AddToCartEvent) {
      _addToCart(event.cartRequest);
    } else if (event is UpdateCartItemEvent) {
      _updateCartItem(event.itemId, event.quantityRequest);
    } else if (event is DeleteCartItemEvent) {
      _deleteCartItem(event.itemId);
    }
  }

  /// Get Cart
  void _getCart() async {
    final response = await _getCartUseCase.call();

    if (response is SuccessResponse<CartResponseEntity>) {
      emit(state.copyWith(cartData: response.data));
    }
  }

  /// Add to Cart
  void _addToCart(CartRequest request) async {
    emit(state.copyWith(
      isUpdatingItem: true,
      updatingItemId: request.product,
    ));

    final response = await _addToCartUseCase.call(request);

    if (response is SuccessResponse<CartResponseEntity>) {
      emit(state.copyWith(
        cartData: response.data,
        isUpdatingItem: false,
        updatingItemId: null,
      ));
    }
  }

  /// Update Cart Item
  void _updateCartItem(String itemId, QuantityRequest request) async {
    emit(state.copyWith(
      isUpdatingItem: true,
      updatingItemId: itemId,
    ));

    final response = await _updateCartItemUseCase.call(itemId, request);

    if (response is SuccessResponse<CartResponseEntity>) {
      emit(state.copyWith(
        cartData: response.data,
        isUpdatingItem: false,
        updatingItemId: null,
      ));
    }
  }

  /// Delete Cart Item
  void _deleteCartItem(String itemId) async {
    emit(state.copyWith(
      isUpdatingItem: true,
      updatingItemId: itemId,
    ));

    final response = await _deleteCartItemUseCase.call(itemId);

    if (response is SuccessResponse<CartResponseEntity>) {
      emit(state.copyWith(
        cartData: response.data,
        isUpdatingItem: false,
        updatingItemId: null,
      ));
    }
  }
}
