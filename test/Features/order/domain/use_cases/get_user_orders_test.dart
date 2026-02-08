import 'package:flowers_app/Features/order/domain/entities/checkout/user_orders_entity.dart';
import 'package:flowers_app/Features/order/domain/entities/checkout/user_orders_response_entity.dart';
import 'package:flowers_app/Features/order/domain/repo/order_repo_contract.dart';
import 'package:flowers_app/Features/order/domain/use_cases/get_user_orders.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flowers_app/core/constants/api_constants.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_user_orders_test.mocks.dart';

@GenerateMocks([OrderRepoContract])
void main() {
  late GetUserOrders getUserOrders;
  late MockOrderRepoContract mockRepo;

  final ordersList = [
    OrdersEntity(orderNumber: "1", state: ApiConstants.completed, isPaid: true),
    OrdersEntity(orderNumber: "2", state: ApiConstants.pending, isPaid: false),
    OrdersEntity(orderNumber: "3", state: "processing", isPaid: false),
  ];

  final successResponse = SuccessResponse<UserOrdersResponseEntity>(
    data: UserOrdersResponseEntity(orders: ordersList),
  );

  setUpAll(() {
    provideDummy<BaseResponse<UserOrdersResponseEntity>>(
      SuccessResponse<UserOrdersResponseEntity>(
        data: UserOrdersResponseEntity(orders: []),
      ),
    );
  });

  setUp(() {
    mockRepo = MockOrderRepoContract();
    getUserOrders = GetUserOrders(mockRepo);
  });

  group('GetUserOrders UseCase Tests', () {
    test(
      'should return only completed orders when filter is OrderFilter.completed',
      () async {
        // Arrange
        when(mockRepo.getUserOrders()).thenAnswer((_) async => successResponse);

        // Act
        final result = await getUserOrders.call(filter: OrderFilter.completed);

        // Assert
        expect(result, isA<SuccessResponse<List<OrdersEntity>>>());
        final data = (result as SuccessResponse<List<OrdersEntity>>).data;
        expect(data.length, 1);
        expect(data.first.state, ApiConstants.completed);
      },
    );

    test(
      'should return pending or unpaid orders when filter is OrderFilter.pending',
      () async {
        // Arrange
        when(mockRepo.getUserOrders()).thenAnswer((_) async => successResponse);

        // Act
        final result = await getUserOrders.call(filter: OrderFilter.pending);

        // Assert
        expect(result, isA<SuccessResponse<List<OrdersEntity>>>());
        final data = (result as SuccessResponse<List<OrdersEntity>>).data;
        expect(data.length, 2);
      },
    );

    test(
      'should return empty list if repository returns empty orders',
      () async {
        // Arrange
        when(mockRepo.getUserOrders()).thenAnswer(
          (_) async =>
              SuccessResponse(data: UserOrdersResponseEntity(orders: [])),
        );

        // Act
        final result = await getUserOrders.call(filter: OrderFilter.completed);

        // Assert
        expect((result as SuccessResponse<List<OrdersEntity>>).data, isEmpty);
      },
    );

    test('should return ErrorResponse when repository fails', () async {
      // Arrange
      when(mockRepo.getUserOrders()).thenAnswer(
        (_) async => ErrorResponse<UserOrdersResponseEntity>(
          errorMessage: "Server Error",
        ),
      );

      // Act
      final result = await getUserOrders.call(filter: OrderFilter.completed);

      // Assert
      expect(result, isA<ErrorResponse<List<OrdersEntity>>>());
      expect((result as ErrorResponse).errorMessage, "Server Error");
    });
  });
}
