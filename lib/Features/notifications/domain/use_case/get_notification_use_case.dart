import 'package:flowers_app/Features/notifications/domain/entities/notification_entity.dart';
import 'package:flowers_app/Features/notifications/domain/repo/notification_repo_contract.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetNotificationUseCase {
  final NotificationRepoContract _repo;
  GetNotificationUseCase(this._repo);
  Stream<BaseResponse<List<NotificationEntity>>> call(String userId) {
    return _repo.getNotifications(userId);
  }
}