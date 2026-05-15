import 'package:bloc_test/bloc_test.dart';
import 'package:flowers_app/Features/order/domain/entities/checkout/user_orders_entity.dart';
import 'package:flowers_app/Features/order/domain/use_cases/get_user_orders.dart';
import 'package:flowers_app/Features/order/presentation/orders/view_model/orders_event.dart';
import 'package:flowers_app/Features/order/presentation/orders/view_model/orders_states.dart';
import 'package:flowers_app/Features/order/presentation/orders/view_model/orders_view_model.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flowers_app/core/constants/api_constants.dart'; // مهم جداً للفلترة
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'orders_view_model_test.mocks.dart';

@GenerateMocks([GetUserOrders])
void main() {
  provideDummy<BaseResponse<List<OrdersEntity>>>(
    SuccessResponse<List<OrdersEntity>>(data: []),
  );
  late OrdersViewModel ordersViewModel;
  late MockGetUserOrders mockGetUserOrders;

  setUp(() {
    mockGetUserOrders = MockGetUserOrders();
    ordersViewModel = OrdersViewModel(mockGetUserOrders);
  });

  tearDown(() {
    ordersViewModel.close();
  });

  group('OrdersViewModel Tests', () {
    test('Initial state should be correct', () {
      expect(ordersViewModel.state, const OrdersState());
    });

    blocTest<OrdersViewModel, OrdersState>(
      'emits [loading:true, success] and filters orders correctly',
      build: () {
        when(mockGetUserOrders.call()).thenAnswer(
              (_) async => SuccessResponse<List<OrdersEntity>>(data: fakeOrdersList),
        );
        return ordersViewModel;
      },
      act: (bloc) => bloc.doIntent(GetUserOrdersEvent()),
      expect: () => [
        const OrdersState(isLoading: true),
        OrdersState(
          isLoading: false,
          allOrders: fakeOrdersList,
          activeOrders: [fakeOrdersList[0]],
          completedOrders: [fakeOrdersList[1]],
        ),
      ],
    );

    blocTest<OrdersViewModel, OrdersState>(
      'emits [loading:true, error] when API fails',
      build: () {
        when(mockGetUserOrders.call()).thenAnswer(
              (_) async => ErrorResponse<List<OrdersEntity>>(errorMessage: 'Server Error'),
        );
        return ordersViewModel;
      },
      act: (bloc) => bloc.doIntent(GetUserOrdersEvent()),
      expect: () => [
        const OrdersState(isLoading: true),
        const OrdersState(isLoading: false, errorMessage: 'Server Error'),
      ],
    );

    blocTest<OrdersViewModel, OrdersState>(
      'emits state with new filter when ChangeOrdersFilterEvent is called',
      build: () => ordersViewModel,
      act: (bloc) => bloc.doIntent(ChangeOrdersFilterEvent(OrderFilter.completed)),
      expect: () => [
        const OrdersState(selectedFilter: OrderFilter.completed),
      ],
    );
  });
}

final fakeOrdersList = [
  OrdersEntity(
    orderNumber: "1",
    totalPrice: 100,
    state: ApiConstants.pending, // logic: active
    isPaid: true,
  ),
  OrdersEntity(
    orderNumber: "2",
    totalPrice: 200,
    state: ApiConstants.completed, // logic: completed
    isPaid: true,
  ),
];