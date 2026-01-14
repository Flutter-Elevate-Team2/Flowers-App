import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

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
])

void main() {
  _registerDummies();
  setUp(_setUpCartViewModel);
  _runCartViewModelTests();
}

void _runCartViewModelTests() {
  group('CartViewModel Tests', () {
    _getCartTest();
    _addToCartTest();
    _updateCartItemTest();
    _deleteCartItemTest();
  });
}

void _getCartTest() {
  blocTest<CartViewModel, CartStates>(
    'GetCartDataEvent emits cartData',
    build: () {
      _stubGetCartSuccess();
      return cartViewModel;
    },
    act: (bloc) => bloc.doIntent(GetCartDataEvent()),
    expect: () => [
      CartStates().copyWith(cartData: fakeCartResponse),
    ],
  );
}

void _addToCartTest() {
  blocTest<CartViewModel, CartStates>(
    'AddToCartEvent emits loading then updated cartData',
    build: () {
      _stubAddToCartSuccess();
      return cartViewModel;
    },
    act: (bloc) => bloc.doIntent(
      AddToCartEvent(
        CartRequest(product: '1', quantity: 1),
      ),
    ),
    expect: () => [
      CartStates().copyWith(isUpdatingItem: true, updatingItemId: '1'),
      CartStates().copyWith(
        cartData: fakeCartResponse,
        isUpdatingItem: false,
        updatingItemId: null,
      ),
    ],
  );
}

void _updateCartItemTest() {
  blocTest<CartViewModel, CartStates>(
    'UpdateCartItemEvent emits loading then updated cartData',
    build: () {
      _stubUpdateCartItemSuccess();
      return cartViewModel;
    },
    act: (bloc) => bloc.doIntent(
      UpdateCartItemEvent(
        itemId: '1',
        quantityRequest: QuantityRequest(quantity: 2),
      ),
    ),
    expect: () => [
      CartStates().copyWith(isUpdatingItem: true, updatingItemId: '1'),
      CartStates().copyWith(
        cartData: fakeCartResponse,
        isUpdatingItem: false,
        updatingItemId: null,
      ),
    ],
  );
}

void _deleteCartItemTest() {
  blocTest<CartViewModel, CartStates>(
    'DeleteCartItemEvent emits loading then updated cartData',
    build: () {
      _stubDeleteCartItemSuccess();
      return cartViewModel;
    },
    act: (bloc) => bloc.doIntent(DeleteCartItemEvent('1')),
    expect: () => [
      CartStates().copyWith(isUpdatingItem: true, updatingItemId: '1'),
      CartStates().copyWith(
        cartData: fakeCartResponse,
        isUpdatingItem: false,
        updatingItemId: null,
      ),
    ],
  );
}

late CartViewModel cartViewModel;
late MockGetCartUseCase mockGetCartUseCase;
late MockAddToCartUseCase mockAddToCartUseCase;
late MockUpdateCartItemUseCase mockUpdateCartItemUseCase;
late MockDeleteCartItemUseCase mockDeleteCartItemUseCase;

final fakeCartResponse = _buildFakeCartResponse();

void _setUpCartViewModel() {
  mockGetCartUseCase = MockGetCartUseCase();
  mockAddToCartUseCase = MockAddToCartUseCase();
  mockUpdateCartItemUseCase = MockUpdateCartItemUseCase();
  mockDeleteCartItemUseCase = MockDeleteCartItemUseCase();

  cartViewModel = CartViewModel(
    mockGetCartUseCase,
    mockAddToCartUseCase,
    mockUpdateCartItemUseCase,
    mockDeleteCartItemUseCase,
  );
}

void _stubGetCartSuccess() {
  when(mockGetCartUseCase.call()).thenAnswer(
        (_) async => SuccessResponse<CartResponseEntity>(
      data: fakeCartResponse,
    ),
  );
}

void _stubAddToCartSuccess() {
  when(mockAddToCartUseCase.call(any)).thenAnswer(
        (_) async => SuccessResponse<CartResponseEntity>(
      data: fakeCartResponse,
    ),
  );
}

void _stubUpdateCartItemSuccess() {
  when(
    mockUpdateCartItemUseCase.call(
      '1',
      argThat(
        isA<QuantityRequest>().having((q) => q.quantity, 'quantity', 2),
      ),
    ),
  ).thenAnswer(
        (_) async => SuccessResponse<CartResponseEntity>(
      data: fakeCartResponse,
    ),
  );
}

void _stubDeleteCartItemSuccess() {
  when(mockDeleteCartItemUseCase.call('1')).thenAnswer(
        (_) async => SuccessResponse<CartResponseEntity>(
      data: fakeCartResponse,
    ),
  );
}

void _registerDummies() {
  provideDummy<BaseResponse<CartResponseEntity>>(
    SuccessResponse<CartResponseEntity>(
      data: CartResponseEntity(
        cart: CartEntity(cartItems: []),
      ),
    ),
  );
}

CartResponseEntity _buildFakeCartResponse() {
  return CartResponseEntity(
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
}
