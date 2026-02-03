import 'package:dio/dio.dart';
import 'package:flowers_app/Features/notifications/data/models/notification_response/notification_response.dart';
import 'package:flowers_app/core/constants/api_constants.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';

part 'notification_api_client.g.dart';

@lazySingleton
@RestApi()
abstract class NotificationApi {
  @factoryMethod
  factory NotificationApi(Dio dio) = _NotificationApi;

  @POST(ApiConstants.notifications)
  Future<NotificationResponse> getNotifications();
}
