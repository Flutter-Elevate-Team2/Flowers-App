import 'package:flowers_app/Features/order/domain/use_cases/get_user_orders.dart';

sealed class OrdersEvent {}

class GetUserOrdersEvent extends OrdersEvent {}

class ChangeOrdersFilterEvent extends OrdersEvent {
  final OrderFilter filter;
  ChangeOrdersFilterEvent(this.filter);
}
