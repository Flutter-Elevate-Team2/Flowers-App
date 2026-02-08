import 'package:equatable/equatable.dart';
import 'package:flowers_app/Features/order/domain/entities/checkout/user_orders_entity.dart';
import 'package:flowers_app/Features/order/domain/use_cases/get_user_orders.dart';

class OrdersState extends Equatable {
  final bool isLoading;
  final bool isFiltering;
  final List<OrdersEntity> allOrders;
  final List<OrdersEntity> completedOrders;
  final List<OrdersEntity> activeOrders;
  final OrderFilter selectedFilter;
  final String? errorMessage;

  const OrdersState({
    this.isLoading = false,
    this.isFiltering = false,
    this.allOrders = const [],
    this.completedOrders = const [],
    this.activeOrders = const [],
    this.selectedFilter = OrderFilter.pending,
    this.errorMessage,
  });

  OrdersState copyWith({
    bool? isLoading,
    bool? isFiltering,
    List<OrdersEntity>? allOrders,
    OrderFilter? selectedFilter,
    List<OrdersEntity>? completedOrders,
    List<OrdersEntity>? activeOrders,
    String? errorMessage,
  }) {
    return OrdersState(
      isLoading: isLoading ?? this.isLoading,
      isFiltering: isFiltering ?? this.isFiltering,
      allOrders: allOrders ?? this.allOrders,
      completedOrders: completedOrders ?? this.completedOrders,
      activeOrders: activeOrders ?? this.activeOrders,
      selectedFilter: selectedFilter ?? this.selectedFilter,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    isFiltering,
    allOrders,
    completedOrders,
    activeOrders,
    selectedFilter,
    errorMessage,
  ];
}
