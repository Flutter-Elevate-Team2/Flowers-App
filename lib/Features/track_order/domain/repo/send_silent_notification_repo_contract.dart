import 'package:flowers_app/core/base_response/base_response.dart';
abstract class SendSilentNotificationRepositoryContract {
  Future<BaseResponse<bool>> sendSilentNotification({
    required String orderId,
    required String driverToken,
  });
}