import 'package:flowers_app/Features/track_order/data/data_sources/remote/send_silent_notification_remot_data_source_contract.dart';
import 'package:flowers_app/Features/track_order/domain/repo/send_silent_notification_repo_contract.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flowers_app/core/helpers/api_execution_mixin.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: SendSilentNotificationRepositoryContract)
class SendSilentNotificationRepositoryImple
    with ApiExecutionMixin
    implements SendSilentNotificationRepositoryContract {
  final SendSilentNotificationDataSourceContract _remoteDataSource;

  SendSilentNotificationRepositoryImple(this._remoteDataSource);

  @override
  Future<BaseResponse<bool>> sendSilentNotification({
    required String orderId,
    required String driverToken,
  }) async {
    return execute<void, bool>(
      action: () => _remoteDataSource.sendSilentNotificationToDriver(
        orderId: orderId,
        driverToken: driverToken,
      ),
      mapper: (_) => true,
    );
  }
}
