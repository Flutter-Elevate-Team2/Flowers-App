import 'package:flowers_app/Features/notifications/data/data_source_contract/notification_remote_data_source_contract.dart';
import 'package:flowers_app/Features/notifications/data/mappers/notification_mapper.dart';
import 'package:flowers_app/Features/notifications/domain/entities/notification_entity.dart';
import 'package:flowers_app/Features/notifications/domain/repo/notification_repo_contract.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flowers_app/core/handle_error/handle_error.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: NotificationRepoContract)
class NotificationRepoImple implements NotificationRepoContract {
  final NotificationRemoteDataSourceContract _remoteDataSource;

  NotificationRepoImple(this._remoteDataSource);

  @override
  Stream<BaseResponse<List<NotificationEntity>>> getNotifications(
    String userId,
  ) {
    return _remoteDataSource
        .getNotifications(userId)
        .map((models) {
          final entities = models.map((model) => model.toEntity()).toList();
          return SuccessResponse<List<NotificationEntity>>(data: entities);
        })
        .handleError((error) {
         
          return ErrorResponse<List<NotificationEntity>>(
            errorMessage: ErrorHandler.handleError(error),
          );
        });
  }

  @override
  Future<BaseResponse<void>> markNotificationAsRead(
    String notificationId,
  ) async {
    try {
      await _remoteDataSource.markNotificationAsRead(notificationId);
      return SuccessResponse<void>(data: null);
    } catch (e) {
      return ErrorResponse<void>(errorMessage: ErrorHandler.handleError(e));
    }
  }
}
