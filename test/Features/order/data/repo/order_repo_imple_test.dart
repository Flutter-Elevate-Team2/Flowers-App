import 'package:flowers_app/Features/commerce/domain/entities/product_entities/product_entity.dart';
import 'package:flowers_app/Features/order/data/data_source/order_remote_data_source/order_remote_data_source_contract.dart';
import 'package:flowers_app/Features/order/data/models/cart/cart_request_dto.dart';
import 'package:flowers_app/Features/order/data/models/cart/cart_response_model.dart';
import 'package:flowers_app/Features/order/data/models/cart/quantity_request.dart';
import 'package:flowers_app/Features/order/data/models/checkout/cash_checkout_response_model.dart';
import 'package:flowers_app/Features/order/data/models/checkout/credit/credit_checkout_response_model.dart';
import 'package:flowers_app/Features/order/data/models/checkout/order_request_dto.dart';
import 'package:flowers_app/Features/order/data/models/checkout/shipping_address_request.dart';
import 'package:flowers_app/Features/order/data/repo/order_repo_imple.dart';
import 'package:flowers_app/Features/order/domain/entities/cart/cart_entity.dart';
import 'package:flowers_app/Features/order/domain/entities/cart/cart_item_entity.dart';
import 'package:flowers_app/Features/order/domain/entities/cart/cart_response_entity.dart';
import 'package:flowers_app/Features/order/domain/entities/checkout/cash_checkout_response_entity.dart';
import 'package:flowers_app/Features/order/domain/entities/checkout/credit_checkout_response_entity.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'order_repo_imple_test.mocks.dart';

@GenerateMocks([OrderRemoteDataSourceContract])
void main() {
  late OrderRepoImple orderRepoImple;
  late MockOrderRemoteDataSourceContract mockOrderRemoteDataSourceContract;
  final ProductEntity fakeProduct = ProductEntity(
    id: "673e2bd91159920171828139",
    title: "Red Wedding Flower",
    description: "This is a Pack of Red Wedding Flowers",
    imgCover:
        "https://flower.elevateegy.com/uploads/5452abf4-2040-43d7-bb3d-3ae8f53c4576-cover_image.png",
    images: [
      "https://flower.elevateegy.com/uploads/ba028e59-410f-43ac-aed5-f4f97c102b98-image_four.png",
      "https://flower.elevateegy.com/uploads/f89bc954-eb0d-4efb-928f-6717f77b69ed-image_one.png",
      "https://flower.elevateegy.com/uploads/5ed2d072-485b-4a53-a0fa-a41412791397-image_three.png",
      "https://flower.elevateegy.com/uploads/c0992ec6-d3c0-4a54-b7ec-4cf000138367-image_two.png",
    ],
    price: 250,
    priceAfterDiscount: 150,
    quantity: 827,
    categoryId: "673c46fd1159920171827c85",
    occasionId: "673b34c21159920171827ae0",
    discount: 20,
    sold: 0,
    slug: "",
    isInWishlist: false,
    rateAvg: 3,
    rateCount: 8,
  );
  final testEntity = CartResponseEntity(
    message: "dummy",
    numOfCartItems: 3,
    cart: CartEntity(
      totalPrice: 900,
      user: "shahd",
      id: "123",
      appliedCoupons: [123, 456, 789],
      cartItems: [
        CartItemEntity(
          quantity: 3,
          id: "690",
          price: 800,
          product: fakeProduct,
        ),
      ],
    ),
  );
  final tCartResponseModel = CartResponseModel(message: "success");
  final tCartRequest = CartRequest(product: "flowers", quantity: 3);
  final tCashCheckoutResponseModel = CashCheckoutResponseModel(
    message: "success",
  );
  final tCreditCheckoutResponseModel = CreditCheckoutResponseModel(
    message: "success",
  );
  final tOrderCheckoutRequest = OrderRequest(
    shippingAddress: ShippingAddressRequest(
      street: "123 Flower St",
      phone: "01000000000",
      city: "Bloomtown",
      lat: "30.0",
      long: "31.0",
    ),
  );
  setUp(() {
    mockOrderRemoteDataSourceContract = MockOrderRemoteDataSourceContract();
    orderRepoImple = OrderRepoImple(mockOrderRemoteDataSourceContract);
    provideDummy<BaseResponse<CartResponseEntity>>(
      SuccessResponse(data: testEntity),
    );
  });
  group("CartRepoImple Tests", () {
    test(
      'should return SuccessResponse when updateCartItem is successful',
      () async {
        // Arrange
        final quantityRequest = QuantityRequest(quantity: 5);

        when(
          mockOrderRemoteDataSourceContract.updateCartItem(any, any),
        ).thenAnswer((_) async => tCartResponseModel);

        // Act
        final result = await orderRepoImple.updateCartItem(
          "123",
          quantityRequest,
        );

        // Assert
        expect(result, isA<SuccessResponse<CartResponseEntity>>());

        verify(
          mockOrderRemoteDataSourceContract.updateCartItem(
            "123",
            argThat(
              isA<QuantityRequest>().having((q) => q.quantity, 'quantity', 5),
            ),
          ),
        ).called(1);
      },
    );
    test(
      'should return SuccessResponse when getCartItem is successful',
      () async {
        when(
          mockOrderRemoteDataSourceContract.getCartData(),
        ).thenAnswer((_) async => tCartResponseModel);
        final result = await orderRepoImple.getCartData();
        expect(result, isA<SuccessResponse<CartResponseEntity>>());
        verify(mockOrderRemoteDataSourceContract.getCartData()).called(1);
      },
    );
    test(
      'should return SuccessResponse when deleteCartItem is successful',
      () async {
        when(
          mockOrderRemoteDataSourceContract.deleteItemFromCart("123"),
        ).thenAnswer((_) async => tCartResponseModel);
        final result = await orderRepoImple.deleteFromCart("123");
        expect(result, isA<SuccessResponse<CartResponseEntity>>());
        verify(
          mockOrderRemoteDataSourceContract.deleteItemFromCart("123"),
        ).called(1);
      },
    );
    test(
      'should return SuccessResponse when updateCartItem is successful',
      () async {
        when(
          mockOrderRemoteDataSourceContract.addToCart(tCartRequest),
        ).thenAnswer((_) async => tCartResponseModel);
        final result = await orderRepoImple.addToCart(tCartRequest);
        expect(result, isA<SuccessResponse<CartResponseEntity>>());
        verify(
          mockOrderRemoteDataSourceContract.addToCart(tCartRequest),
        ).called(1);
      },
    );
    test(
      'should return SuccessResponse when cashOrderCheckout is successful',
      () async {
        when(
          mockOrderRemoteDataSourceContract.cashOrderCheckout(
            tOrderCheckoutRequest,
          ),
        ).thenAnswer((_) async => tCashCheckoutResponseModel);
        final result = await orderRepoImple.cashOrderCheckout(
          tOrderCheckoutRequest,
        );
        expect(result, isA<SuccessResponse<CashCheckoutResponseEntity>>());
        verify(
          mockOrderRemoteDataSourceContract.cashOrderCheckout(
            tOrderCheckoutRequest,
          ),
        ).called(1);
      },
    );
    test(
      'should return SuccessResponse when creditOrderCheckout is successful',
          () async {
        when(
          mockOrderRemoteDataSourceContract.creditOrderCheckout(
            tOrderCheckoutRequest,
          ),
        ).thenAnswer((_) async => tCreditCheckoutResponseModel);
        final result = await orderRepoImple.creditOrderCheckout(
          tOrderCheckoutRequest,
        );
        expect(result, isA<SuccessResponse<CreditCheckoutResponseEntity>>());
        verify(
          mockOrderRemoteDataSourceContract.creditOrderCheckout(
            tOrderCheckoutRequest,
          ),
        ).called(1);
      },
    );
  });
}
