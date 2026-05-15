import 'package:flowers_app/Features/commerce/domain/entities/product_entities/product_entity.dart';
import 'package:flowers_app/Features/order/domain/entities/cart/cart_entity.dart';
import 'package:flowers_app/Features/order/domain/entities/cart/cart_item_entity.dart';
import 'package:flowers_app/Features/order/domain/entities/cart/cart_response_entity.dart';
import 'package:flowers_app/Features/order/domain/repo/order_repo_contract.dart';
import 'package:flowers_app/Features/order/domain/use_cases/cart/get_cart_use_case.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_cart_use_case_test.mocks.dart';

@GenerateMocks([OrderRepoContract])
void main() {
  late GetCartUseCase getCartUseCase;
  late MockOrderRepoContract mockOrderRepoContract;
  late ProductEntity fakeProduct = ProductEntity(
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
  setUp(() {
    provideDummy<BaseResponse<CartResponseEntity>>(
      SuccessResponse(
        data: CartResponseEntity(
          message: "dummy",
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
        ),
      ),
    );
    mockOrderRepoContract = MockOrderRepoContract();
    getCartUseCase = GetCartUseCase(mockOrderRepoContract);
  });
  test(
    "should call GetCartItemUseCase.call() and return SuccessResponse",
        () async {
      when(
        mockOrderRepoContract.getCartData(),
      ).thenAnswer((_) async => SuccessResponse(data: testEntity));
      final result = await getCartUseCase.call();
      expect(result, isA<SuccessResponse<CartResponseEntity>>());
      verify(mockOrderRepoContract.getCartData()).called(1);
    },
  );
}