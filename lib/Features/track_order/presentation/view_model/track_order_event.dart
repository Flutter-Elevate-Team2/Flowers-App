
sealed class TrackOrderStatusEvent {}

class FetchOrderDetailsEvent extends TrackOrderStatusEvent {
  final String orderId;
  FetchOrderDetailsEvent(this.orderId);
}
