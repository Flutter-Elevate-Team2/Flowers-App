import 'package:flowers_app/Features/notifications/data/data_source_contract/notification_remote_data_source_contract.dart';
import 'package:flowers_app/Features/notifications/data/mappers/notification_mapper.dart';
import 'package:flowers_app/Features/notifications/data/models/notification_response/notification_response.dart';
import 'package:flowers_app/Features/notifications/domain/entities/notification_data.dart';
import 'package:flowers_app/Features/notifications/domain/repo/notification_repo_contract.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flowers_app/core/helpers/api_execution_mixin.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: NotificationRepoContract)
class NotificationRepoImple
    with ApiExecutionMixin
    implements NotificationRepoContract {
  final NotificationRemoteDataSourceContract _remoteDataSource;
  NotificationRepoImple(this._remoteDataSource);
  @override
  Future<BaseResponse<NotificationData>> getNotifications() async {
    return execute<NotificationResponse, NotificationData>(
      action: () async => await _remoteDataSource.getNotifications(),
      mapper: (response) => response.toNotificationData(),
    );
  }
}
