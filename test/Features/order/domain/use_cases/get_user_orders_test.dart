import 'package:flowers_app/Features/order/domain/entities/checkout/orders_metadata_entity.dart';
import 'package:flowers_app/Features/order/domain/entities/checkout/user_orders_entity.dart';
import 'package:flowers_app/Features/order/domain/entities/checkout/user_orders_response_entity.dart';
import 'package:flowers_app/Features/order/domain/repo/order_repo_contract.dart';
import 'package:flowers_app/Features/order/domain/use_cases/get_user_orders.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'cart/add_to_cart_use_case_test.mocks.dart';




@GenerateMocks([OrderRepoContract])
void main() {
  provideDummy<BaseResponse<UserOrdersResponseEntity>>(
      SuccessResponse(
        data: UserOrdersResponseEntity(
          message: "success",
          orders: [],
          metadata: OrdersMetadata(),
        ),
      )
  );
  late GetUserOrders userOrdersUseCase;
  late MockOrderRepoContract mockOrderRepoContract;


  setUp(() {
    mockOrderRepoContract = MockOrderRepoContract();
    userOrdersUseCase = GetUserOrders(mockOrderRepoContract);

  });

  test(
    "when call GetUserOrders should return SuccessResponse",
        () async {
      // Arrange

          final userOrdersEntity = UserOrdersResponseEntity(
            message: 'success',
            metadata: OrdersMetadata(
              currentPage: 1,
              totalPages: 1,
              limit: 10,
              totalItems: 1,
            ),
            orders: const <OrdersEntity>[],
          );

      final successResponse = SuccessResponse<UserOrdersResponseEntity>(
        data: userOrdersEntity,
      );
      when(
        mockOrderRepoContract.getUserOrders(),
      ).thenAnswer((_) async => successResponse);

      // Act
      final result = await userOrdersUseCase.call();

      // Assert
      expect(result, isA<SuccessResponse<UserOrdersResponseEntity>>());
      verify(mockOrderRepoContract.getUserOrders()).called(1);
    },
  );
}

