import 'package:flowers_app/Features/order/data/models/checkout/order_request_dto.dart';
import 'package:flowers_app/Features/order/data/models/checkout/shipping_address_request.dart';
import 'package:flowers_app/Features/order/domain/entities/checkout/cash_checkout_response_entity.dart';
import 'package:flowers_app/Features/order/domain/entities/checkout/order_entity.dart';
import 'package:flowers_app/Features/order/domain/repo/order_repo_contract.dart';
import 'package:flowers_app/Features/order/domain/use_cases/checkout/cash_order_checkout.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../cart/add_to_cart_use_case_test.mocks.dart';



@GenerateMocks([OrderRepoContract])
void main() {
  provideDummy<BaseResponse<CashCheckoutResponseEntity>>(
    SuccessResponse(
      data: CashCheckoutResponseEntity(
        message: "success",
        order: OrderEntity(
          id: "order123",
          totalPrice: 1500,
          user:"dummyUser",
          isPaid: false,
          isDelivered: false,
          paymentType: "cash",
          state: "pending",
          orderItems: [],
        ),
      ),
    )
  );
  late CashOrderCheckout cashUseCase;
  late MockOrderRepoContract mockOrderRepoContract;


  setUp(() {
    mockOrderRepoContract = MockOrderRepoContract();
    cashUseCase = CashOrderCheckout(mockOrderRepoContract);

  });

  test(
    "when call CashOrderCheckout should return SuccessResponse",
        () async {
      // Arrange
      final orderRequest = OrderRequest(
        shippingAddress: ShippingAddressRequest(
          street: "123 Main St",
          city: "Springfield",
          lat: "IL",
          phone: "62701",
          long: "USA",
        ),
      );

      final cashCheckoutEntity = CashCheckoutResponseEntity(
        message: 'success',
        order: OrderEntity(
          id: "order123",
          totalPrice: 1500,
          user:"dummyUser",
          isPaid: false,
          isDelivered: false,
          paymentType: "cash",
          state: "pending",
          orderItems: [],
        )
      );

      final successResponse = SuccessResponse<CashCheckoutResponseEntity>(
        data: cashCheckoutEntity,
      );
      when(
        mockOrderRepoContract.cashOrderCheckout(orderRequest),
      ).thenAnswer((_) async => successResponse);

      // Act
      final result = await cashUseCase.call(orderRequest);

      // Assert
      expect(result, isA<SuccessResponse<CashCheckoutResponseEntity>>());
      verify(mockOrderRepoContract.cashOrderCheckout(orderRequest)).called(1);
    },
  );
}

