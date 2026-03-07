import 'package:flowers_app/Features/order/domain/entities/checkout/user_orders_entity.dart';
import 'package:flowers_app/Features/order/domain/entities/checkout/user_orders_response_entity.dart';
import 'package:flowers_app/Features/order/domain/repo/order_repo_contract.dart';
import 'package:flowers_app/Features/order/domain/use_cases/get_user_orders.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

 @GenerateMocks([OrderRepoContract])
import 'get_user_orders_test.mocks.dart';

void main() {
  late GetUserOrders getUserOrders;
  late MockOrderRepoContract mockOrderRepo;

  setUpAll(() {
     provideDummy<BaseResponse<UserOrdersResponseEntity>>(
      SuccessResponse(data: UserOrdersResponseEntity(orders: [])),
    );
  });

  setUp(() {
    mockOrderRepo = MockOrderRepoContract();
    getUserOrders = GetUserOrders(mockOrderRepo);
  });

  group('GetUserOrders Use Case Tests', () {
    test('should return SuccessResponse with List<OrdersEntity> when Repo returns Success', () async {
      // Arrange
      final tOrdersList = [
        OrdersEntity(),
      ];
      final tResponseEntity = UserOrdersResponseEntity(orders: tOrdersList);

      when(mockOrderRepo.getUserOrders()).thenAnswer(
            (_) async => SuccessResponse<UserOrdersResponseEntity>(data: tResponseEntity),
      );

      // Act
      final result = await getUserOrders.call();

      // Assert
      expect(result, isA<SuccessResponse<List<OrdersEntity>>>());
      final successResult = result as SuccessResponse<List<OrdersEntity>>;
      expect(successResult.data, tOrdersList);
    });

    test('should return ErrorResponse when Repo returns ErrorResponse', () async {
      // Arrange
      const tErrorMessage = "Server Error";
      when(mockOrderRepo.getUserOrders()).thenAnswer(
            (_) async => ErrorResponse<UserOrdersResponseEntity>(errorMessage: tErrorMessage),
      );

      // Act
      final result = await getUserOrders.call();

      // Assert
      expect(result, isA<ErrorResponse<List<OrdersEntity>>>());
      expect((result as ErrorResponse).errorMessage, tErrorMessage);
    });
  });
}