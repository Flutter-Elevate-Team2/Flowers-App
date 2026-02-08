import 'package:flowers_app/Features/order/domain/entities/cart/cart_entity.dart';
import 'package:flowers_app/Features/order/domain/entities/cart/cart_response_entity.dart';
import 'package:flowers_app/Features/order/domain/repo/order_repo_contract.dart';
import 'package:flowers_app/Features/order/domain/use_cases/cart/clear_user_cart_use_case.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../checkout/cash_order_checkout_test.mocks.dart';


@GenerateMocks([OrderRepoContract])
void main() {
  late ClearCartUseCase clearCartUseCase;
  late MockOrderRepoContract mockOrderRepoContract;


  final testEntity = CartResponseEntity(
    message: "Cart cleared successfully",
    numOfCartItems: 0,
    cart: CartEntity(
      totalPrice: 0,
      user: "Malak",
      id: "123",
      appliedCoupons: [],
      cartItems: [],
    ),
  );

  setUp(() {
    provideDummy<BaseResponse<CartResponseEntity>>(
      SuccessResponse(data: testEntity),
    );

    mockOrderRepoContract = MockOrderRepoContract();
    clearCartUseCase = ClearCartUseCase(mockOrderRepoContract);
  });

  group('ClearCartUseCase Unit Tests', () {
    test(
      "should call ClearCartUseCase.call() and return SuccessResponse",
          () async {
        // Arrange
        when(mockOrderRepoContract.clearUserCart()).thenAnswer(
              (_) async => SuccessResponse(data: testEntity),
        );

        // Act
        final result = await clearCartUseCase.call();

        // Assert
        expect(result, isA<SuccessResponse<CartResponseEntity>>());
        expect((result as SuccessResponse).data, testEntity);
        verify(mockOrderRepoContract.clearUserCart()).called(1);
      },
    );

    test(
      "should return ErrorResponse when repository fails to clear cart",
          () async {
        // Arrange
        final errorResponse = ErrorResponse<CartResponseEntity>(
          errorMessage: 'Failed to clear cart',
        );
        when(mockOrderRepoContract.clearUserCart()).thenAnswer(
              (_) async => errorResponse,
        );

        // Act
        final result = await clearCartUseCase.call();

        // Assert
        expect(result, isA<ErrorResponse<CartResponseEntity>>());
        expect((result as ErrorResponse).errorMessage, 'Failed to clear cart');
        verify(mockOrderRepoContract.clearUserCart()).called(1);
      },
    );
  });
}