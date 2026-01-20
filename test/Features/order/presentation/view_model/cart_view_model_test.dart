import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flowers_app/core/utils/debouncer/immediate_debouncer.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flowers_app/Features/auth/domain/use_cases/valid_token_usecase.dart';
import 'package:flowers_app/core/controller/session_controller.dart';
import 'package:flowers_app/Features/commerce/domain/entities/product_entities/product_entity.dart';
import 'package:flowers_app/Features/order/data/models/cart_request_dto.dart';
import 'package:flowers_app/Features/order/data/models/quantity_request.dart';
import 'package:flowers_app/Features/order/domain/entities/cart_entity.dart';
import 'package:flowers_app/Features/order/domain/entities/cart_item_entity.dart';
import 'package:flowers_app/Features/order/domain/entities/cart_response_entity.dart';
import 'package:flowers_app/Features/order/domain/use_cases/add_to_cart_use_case.dart';
import 'package:flowers_app/Features/order/domain/use_cases/delete_cart_item_use_case.dart';
import 'package:flowers_app/Features/order/domain/use_cases/get_cart_use_case.dart';
import 'package:flowers_app/Features/order/domain/use_cases/update_cart_item_use_case.dart';
import 'package:flowers_app/Features/order/presentation/view_model/cart_events.dart';
import 'package:flowers_app/Features/order/presentation/view_model/cart_states.dart';
import 'package:flowers_app/Features/order/presentation/view_model/cart_view_model.dart';
import 'package:flowers_app/core/base_response/base_response.dart';

import 'cart_view_model_test.mocks.dart';

@GenerateMocks([
  GetCartUseCase,
  AddToCartUseCase,
  UpdateCartItemUseCase,
  DeleteCartItemUseCase,
  HasValidTokenUseCase,
  SessionController,
])
void main() {
  provideDummy<BaseResponse<CartResponseEntity>>(
    SuccessResponse<CartResponseEntity>(data: fakeCartResponse),
  );

  late CartViewModel cartViewModel;
  late MockGetCartUseCase mockGetCartUseCase;
  late MockAddToCartUseCase mockAddToCartUseCase;
  late MockUpdateCartItemUseCase mockUpdateCartItemUseCase;
  late MockDeleteCartItemUseCase mockDeleteCartItemUseCase;
  late MockHasValidTokenUseCase mockHasValidTokenUseCase;
  late MockSessionController mockSessionController;

  CartStates initialState() => const CartStates();

  setUp(() {
    mockGetCartUseCase = MockGetCartUseCase();
    mockAddToCartUseCase = MockAddToCartUseCase();
    mockUpdateCartItemUseCase = MockUpdateCartItemUseCase();
    mockDeleteCartItemUseCase = MockDeleteCartItemUseCase();
    mockHasValidTokenUseCase = MockHasValidTokenUseCase();
    mockSessionController = MockSessionController();

    when(mockSessionController.onLogin).thenAnswer((_) => const Stream.empty());
    when(
      mockSessionController.onLogout,
    ).thenAnswer((_) => const Stream.empty());

    cartViewModel = CartViewModel(
      mockGetCartUseCase,
      mockAddToCartUseCase,
      mockUpdateCartItemUseCase,
      mockDeleteCartItemUseCase,
      mockHasValidTokenUseCase,
      mockSessionController,
      ImmediateDebouncer(),
    );
  });

  group('CartViewModel – Optimistic UI Tests', () {
    blocTest<CartViewModel, CartStates>(
      'GetCartDataEvent emits final cartData with server quantities',
      build: () {
        when(mockHasValidTokenUseCase.call()).thenAnswer((_) async => true);
        _stubGetCartSuccess(mockGetCartUseCase);
        return cartViewModel;
      },
      act: (bloc) => bloc.doIntent(GetCartDataEvent()),
      expect: () => [CartStates.fromCart(fakeCartResponse)],
    );

    blocTest<CartViewModel, CartStates>(
      'AddToCart emits ONE optimistic state then final cartData',
      build: () {
        when(mockHasValidTokenUseCase.call()).thenAnswer((_) async => true);
        _stubAddToCartSuccess(mockAddToCartUseCase);
        return cartViewModel;
      },
      act: (bloc) =>
          bloc.doIntent(AddToCartEvent(CartRequest(product: '1', quantity: 1))),
      expect: () => [
        initialState().copyWith(
          optimisticQuantities: {'1': 1},
          updatingItemIds: {'1'},
        ),
        CartStates.fromCart(fakeCartResponse),
      ],
    );

    blocTest<CartViewModel, CartStates>(
      'UpdateCartItem emits ONE optimistic state then final cartData',
      build: () {
        _stubUpdateCartItemSuccess(mockUpdateCartItemUseCase);
        return cartViewModel;
      },
      act: (bloc) => bloc.doIntent(
        UpdateCartItemEvent(
          itemId: '1',
          quantityRequest: QuantityRequest(quantity: 2),
        ),
      ),
      expect: () => [
        initialState().copyWith(
          optimisticQuantities: {'1': 2},
          updatingItemIds: {'1'},
        ),
        CartStates.fromCart(fakeCartResponse),
      ],
    );

    blocTest<CartViewModel, CartStates>(
      'DeleteCartItem emits optimistic zero then final cartData',
      build: () {
        _stubDeleteCartItemSuccess(mockDeleteCartItemUseCase);
        return cartViewModel;
      },
      act: (bloc) => bloc.doIntent(DeleteCartItemEvent('1')),
      expect: () => [
        initialState().copyWith(
          optimisticQuantities: {'1': 0},
          updatingItemIds: {'1'},
        ),
        CartStates.fromCart(fakeCartResponse),
      ],
    );

    blocTest<CartViewModel, CartStates>(
      'AddToCart emits requiresLogin when not logged in and never calls UseCase',
      build: () {
        when(mockHasValidTokenUseCase.call()).thenAnswer((_) async => false);
        return cartViewModel;
      },
      act: (bloc) =>
          bloc.doIntent(AddToCartEvent(CartRequest(product: '1', quantity: 1))),
      expect: () => [initialState().copyWith(requiresLogin: true)],
      verify: (_) {
        verifyNever(mockAddToCartUseCase.call(any));
      },
    );
  });
}

/// -------------------- STUBS --------------------

void _stubGetCartSuccess(MockGetCartUseCase mock) {
  when(mock.call()).thenAnswer(
    (_) async => SuccessResponse<CartResponseEntity>(data: fakeCartResponse),
  );
}

void _stubAddToCartSuccess(MockAddToCartUseCase mock) {
  when(mock.call(any)).thenAnswer(
    (_) async => SuccessResponse<CartResponseEntity>(data: fakeCartResponse),
  );
}

void _stubUpdateCartItemSuccess(MockUpdateCartItemUseCase mock) {
  when(
    mock.call(
      '1',
      argThat(isA<QuantityRequest>().having((q) => q.quantity, 'quantity', 2)),
    ),
  ).thenAnswer(
    (_) async => SuccessResponse<CartResponseEntity>(data: fakeCartResponse),
  );
}

void _stubDeleteCartItemSuccess(MockDeleteCartItemUseCase mock) {
  when(mock.call('1')).thenAnswer(
    (_) async => SuccessResponse<CartResponseEntity>(data: fakeCartResponse),
  );
}

/// -------------------- FAKE DATA --------------------

final fakeCartResponse = CartResponseEntity(
  cart: CartEntity(
    cartItems: [
      CartItemEntity(
        product: ProductEntity(
          id: '1',
          title: 'Product 1',
          price: 10,
          slug: '',
          description: '',
          imgCover: '',
          images: const [],
          priceAfterDiscount: 0,
          quantity: 0,
          categoryId: '',
          occasionId: '',
          sold: 0,
          rateAvg: 0,
          rateCount: 0,
          isInWishlist: false,
          discount: 0,
        ),
        quantity: 1,
      ),
    ],
  ),
);
