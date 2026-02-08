import 'package:flowers_app/Features/notifications/api/api_client/notification_api_client.dart';
import 'package:flowers_app/Features/notifications/data/data_source_contract/notification_remote_data_source_contract.dart';
import 'package:flowers_app/Features/notifications/data/models/notification_response/notification_response.dart';
import 'package:injectable/injectable.dart';
@Injectable(as: NotificationRemoteDataSourceContract)
class NotificationRemoteDataSourceImple implements NotificationRemoteDataSourceContract {
  final NotificationApi _api;
  NotificationRemoteDataSourceImple(this._api);
  @override
  Future<NotificationResponse> getNotifications() async{
     return await _api.getNotifications();
    
  }
  
}