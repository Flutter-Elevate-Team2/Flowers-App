import 'package:flowers_app/Features/notifications/data/data_source_contract/notification_remote_data_source_contract.dart';
import 'package:flowers_app/Features/notifications/data/mappers/notification_mapper.dart';
import 'package:flowers_app/Features/notifications/data/models/notification_response/notification_response.dart';
import 'package:flowers_app/Features/notifications/domain/entities/notification_entity.dart';
import 'package:flowers_app/Features/notifications/domain/repo/notification_repo_contract.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flowers_app/core/helpers/api_execution_mixin.dart';

class NotificationRepoImple with ApiExecutionMixin implements NotificationRepoContract {
  final NotificationRemoteDataSourceContract _remoteDataSource;
  NotificationRepoImple(this._remoteDataSource);
  @override
  Future<BaseResponse<List<NotificationEntity>>> getNotifications()async {
    return execute<NotificationResponse, List<NotificationEntity>>(
      action: ()async =>await  _remoteDataSource.getNotifications(),
     mapper:(response)=>response.toEntityList(),
      );
  }

}
  