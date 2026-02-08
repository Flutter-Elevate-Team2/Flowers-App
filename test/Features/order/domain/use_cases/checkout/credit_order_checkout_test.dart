import 'package:flowers_app/Features/order/data/models/checkout/order_request_dto.dart';
import 'package:flowers_app/Features/order/data/models/checkout/shipping_address_request.dart';
import 'package:flowers_app/Features/order/domain/entities/checkout/credit_checkout_response_entity.dart';
import 'package:flowers_app/Features/order/domain/entities/checkout/session_entity.dart';
import 'package:flowers_app/Features/order/domain/repo/order_repo_contract.dart';
import 'package:flowers_app/Features/order/domain/use_cases/checkout/credit_card_checkout.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../cart/add_to_cart_use_case_test.mocks.dart';



@GenerateMocks([OrderRepoContract])
void main() {
  provideDummy<BaseResponse<CreditCheckoutResponseEntity>>(
      SuccessResponse(
        data: CreditCheckoutResponseEntity(
          message: "success",
          session: SessionEntity(
          ),
        ),
      )
  );
  late CreditCardCheckout creditUseCase;
  late MockOrderRepoContract mockOrderRepoContract;


  setUp(() {
    mockOrderRepoContract = MockOrderRepoContract();
    creditUseCase = CreditCardCheckout(mockOrderRepoContract);

  });

  test(
    "when call CreditOrderCheckout should return SuccessResponse",
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

      final creditCheckoutEntity = CreditCheckoutResponseEntity(
          message: 'Success',
          session: SessionEntity(
          )
      );

      final successResponse = SuccessResponse<CreditCheckoutResponseEntity>(
        data: creditCheckoutEntity,
      );
      when(
        mockOrderRepoContract.creditOrderCheckout(orderRequest),
      ).thenAnswer((_) async => successResponse);

      // Act
      final result = await creditUseCase.call(orderRequest);

      // Assert
      expect(result, isA<SuccessResponse<CreditCheckoutResponseEntity>>());
      verify(mockOrderRepoContract.creditOrderCheckout(orderRequest)).called(1);
    },
  );
}

