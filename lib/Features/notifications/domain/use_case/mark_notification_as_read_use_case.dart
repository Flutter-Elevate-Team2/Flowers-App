import 'package:flowers_app/Features/notifications/domain/repo/notification_repo_contract.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:injectable/injectable.dart';

@injectable
class MarkNotificationAsReadUseCase {
  final NotificationRepoContract _repo;

  MarkNotificationAsReadUseCase(this._repo);

  Future<BaseResponse<void>> call(String notificationId) {
    return _repo.markNotificationAsRead(notificationId);
  }
}
