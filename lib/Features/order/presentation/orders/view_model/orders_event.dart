sealed class OrdersEvent {}

class GetUserOrdersEvent extends OrdersEvent {}

class ChangeOrdersFilterEvent extends OrdersEvent {
  final OrderFilter filter;
  ChangeOrdersFilterEvent(this.filter);
}

enum OrderFilter {
  pending,
  completed,
}
