import 'package:flowers_app/Features/track_order/domain/repo/send_silent_notification_repo_contract.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:injectable/injectable.dart';

@injectable
class SendSilentNotificationUseCase {
  final SendSilentNotificationRepositoryContract _repository;

  SendSilentNotificationUseCase(this._repository);

  Future<BaseResponse<bool>> call({
    required String orderId,
    required String driverToken,
  }) async {
    return await _repository.sendSilentNotification(
      orderId: orderId,
      driverToken: driverToken,
    );
  }
}