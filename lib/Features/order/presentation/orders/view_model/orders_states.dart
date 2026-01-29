import 'package:equatable/equatable.dart';
import 'package:flowers_app/Features/order/domain/entities/checkout/user_orders_entity.dart';
import 'package:flowers_app/Features/order/presentation/orders/view_model/orders_event.dart';

class OrdersState extends Equatable {
  final bool isLoading;
  final List<OrdersEntity> allOrders;
  final List<OrdersEntity> filteredOrders;
  final OrderFilter selectedFilter;
  final String? errorMessage;

  const OrdersState({
    this.isLoading = false,
    this.allOrders = const [],
    this.filteredOrders = const [],
    this.selectedFilter = OrderFilter.pending,
    this.errorMessage,
  });

  OrdersState copyWith({
    bool? isLoading,
    List<OrdersEntity>? allOrders,
    List<OrdersEntity>? filteredOrders,
    OrderFilter? selectedFilter,
    String? errorMessage,
  }) {
    return OrdersState(
      isLoading: isLoading ?? this.isLoading,
      allOrders: allOrders ?? this.allOrders,
      filteredOrders: filteredOrders ?? this.filteredOrders,
      selectedFilter: selectedFilter ?? this.selectedFilter,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    allOrders,
    filteredOrders,
    selectedFilter,
    errorMessage,
  ];
}
