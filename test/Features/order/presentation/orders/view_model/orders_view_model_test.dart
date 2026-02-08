import 'package:bloc_test/bloc_test.dart';
import 'package:flowers_app/Features/order/domain/entities/checkout/user_orders_entity.dart';
import 'package:flowers_app/Features/order/domain/use_cases/get_user_orders.dart';
import 'package:flowers_app/Features/order/presentation/orders/view_model/orders_event.dart';
import 'package:flowers_app/Features/order/presentation/orders/view_model/orders_states.dart';
import 'package:flowers_app/Features/order/presentation/orders/view_model/orders_view_model.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'orders_view_model_test.mocks.dart';

@GenerateMocks([GetUserOrders])
void main() {
  provideDummy<BaseResponse<List<OrdersEntity>>>(
    SuccessResponse<List<OrdersEntity>>(data: fakeOrdersList),
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

  group('OrdersViewModel Detailed Tests', () {

    test('Initial state should be OrdersState with default values', () {
      expect(ordersViewModel.state, const OrdersState());
      expect(ordersViewModel.state.isLoading, false);
      expect(ordersViewModel.state.selectedFilter, OrderFilter.pending);
    });

    blocTest<OrdersViewModel, OrdersState>(
      'emits [loading, success] with activeOrders when GetUserOrdersEvent is called (Pending)',
      build: () {
        _stubGetOrdersSuccess(mockGetUserOrders);
        return ordersViewModel;
      },
      act: (bloc) => bloc.doIntent(GetUserOrdersEvent()),
      expect: () => [
        const OrdersState().copyWith(isLoading: true),
        const OrdersState().copyWith(
          isLoading: false,
          allOrders: fakeOrdersList,
          activeOrders: fakeOrdersList,
        ),
      ],
    );

    blocTest<OrdersViewModel, OrdersState>(
      'emits [loading, success] with completedOrders when filter is completed',
      seed: () => const OrdersState(selectedFilter: OrderFilter.completed),
      build: () {
        _stubGetOrdersSuccess(mockGetUserOrders);
        return ordersViewModel;
      },
      act: (bloc) => bloc.doIntent(GetUserOrdersEvent()),
      expect: () => [
        const OrdersState(selectedFilter: OrderFilter.completed, isLoading: true),
        OrdersState(
          selectedFilter: OrderFilter.completed,
          isLoading: false,
          allOrders: fakeOrdersList,
          completedOrders: fakeOrdersList,
        ),
      ],
    );

    blocTest<OrdersViewModel, OrdersState>(
      'emits [loading, error] when GetUserOrdersEvent fails',
      build: () {
        when(mockGetUserOrders.call(filter: anyNamed('filter'))).thenAnswer(
              (_) async => ErrorResponse<List<OrdersEntity>>(errorMessage: 'Server Error'),
        );
        return ordersViewModel;
      },
      act: (bloc) => bloc.doIntent(GetUserOrdersEvent()),
      expect: () => [
        const OrdersState().copyWith(isLoading: true),
        const OrdersState().copyWith(isLoading: false, errorMessage: 'Server Error'),
      ],
    );

    blocTest<OrdersViewModel, OrdersState>(
      'emits [filtering, success] for completed orders when filter changed',
      build: () {
        _stubGetOrdersSuccess(mockGetUserOrders);
        return ordersViewModel;
      },
      act: (bloc) => bloc.doIntent(ChangeOrdersFilterEvent(OrderFilter.completed)),
      expect: () => [
        const OrdersState().copyWith(isFiltering: true, selectedFilter: OrderFilter.completed),
        const OrdersState().copyWith(
          isFiltering: false,
          selectedFilter: OrderFilter.completed,
          completedOrders: fakeOrdersList,
        ),
      ],
    );

    blocTest<OrdersViewModel, OrdersState>(
      'emits [filtering, success] for pending orders when filter changed',
      build: () {
        _stubGetOrdersSuccess(mockGetUserOrders);
        return ordersViewModel;
      },
      act: (bloc) => bloc.doIntent(ChangeOrdersFilterEvent(OrderFilter.pending)),
      expect: () => [
        const OrdersState().copyWith(isFiltering: true, selectedFilter: OrderFilter.pending),
        const OrdersState().copyWith(
          isFiltering: false,
          selectedFilter: OrderFilter.pending,
          activeOrders: fakeOrdersList,
        ),
      ],
    );

    blocTest<OrdersViewModel, OrdersState>(
      'stops filtering when ChangeOrdersFilterEvent fails',
      build: () {
        when(mockGetUserOrders.call(filter: anyNamed('filter'))).thenAnswer(
              (_) async => ErrorResponse<List<OrdersEntity>>(errorMessage: 'Filter Error'),
        );
        return ordersViewModel;
      },
      act: (bloc) => bloc.doIntent(ChangeOrdersFilterEvent(OrderFilter.completed)),
      expect: () => [
        const OrdersState().copyWith(isFiltering: true, selectedFilter: OrderFilter.completed),
        const OrdersState().copyWith(isFiltering: false, selectedFilter: OrderFilter.completed),
      ],
    );
  });
}

void _stubGetOrdersSuccess(MockGetUserOrders mock) {
  when(mock.call(filter: anyNamed('filter'))).thenAnswer(
        (_) async => SuccessResponse<List<OrdersEntity>>(data: fakeOrdersList),
  );
}

final fakeOrdersList = [
  OrdersEntity(
    orderNumber: "123456",
    totalPrice: 600,
    updatedAt: "2026-01-29T04:05:41.294Z",
  ),
];