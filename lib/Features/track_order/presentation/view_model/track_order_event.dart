
sealed class TrackOrderStatusEvent {}

class FetchOrderDetailsEvent extends TrackOrderStatusEvent {
  final String orderId;
  FetchOrderDetailsEvent(this.orderId);
}
class SendSilentNotificationEvent extends TrackOrderStatusEvent {
  final String orderId;
  final String driverToken;
  SendSilentNotificationEvent({required this.orderId, required this.driverToken});
}
