abstract class SendSilentNotificationDataSourceContract {
  Future<void> sendSilentNotificationToDriver({
    required String orderId,
    required String driverToken,
  });
}
