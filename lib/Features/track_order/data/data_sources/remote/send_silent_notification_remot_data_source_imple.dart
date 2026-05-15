import 'dart:convert';

import 'package:flowers_app/Features/track_order/data/data_sources/remote/send_silent_notification_remot_data_source_contract.dart';
import 'package:flowers_app/core/handle_error/handle_error.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

@LazySingleton(as: SendSilentNotificationDataSourceContract)
class SendSilentNotificationDataSourceImple
    implements SendSilentNotificationDataSourceContract {
  @override
  Future<void> sendSilentNotificationToDriver({
    required String orderId,
    required String driverToken,
  }) async {
    final String response = await rootBundle.loadString(
      'assets/json/tracking-app-service.json',
    );
    final serviceAccountJson = json.decode(response);
    final scopes = ['https://www.googleapis.com/auth/firebase.messaging'];
    final String projectId = serviceAccountJson['project_id'];

    final authClient = await auth.clientViaServiceAccount(
      auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
      scopes,
    );

    final String accessToken = authClient.credentials.accessToken.data;
    authClient.close();
    print("====================================");
    print("🚨 THE DRIVER TOKEN IS: ->$driverToken<-");
    print("🚨 TOKEN LENGTH: ${driverToken.length}");
    print("====================================");

    final http.Response httpResponse = await http.post(
      Uri.parse(
        'https://fcm.googleapis.com/v1/projects/$projectId/messages:send',
      ),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode({
        'message': {
          'token': driverToken,
          'data': {
            'action': 'customer_confirmed',
            'orderId': orderId,
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'status': 'silent', // Will be overridden if needed
          },
          'android': {'priority': 'high'},
          'apns': {
            'payload': {
              'aps': {'content-available': 1},
            },
          },
        },
      }),
    );

    if (httpResponse.statusCode == 200 || httpResponse.statusCode == 201) {
      if (kDebugMode) {
        print("✅ Silent Notification Sent!");
      }
      return;
    }

    // Non-success status code → throw a typed exception
    if (kDebugMode)
      print("❌ FCM Failed [${httpResponse.statusCode}]: ${httpResponse.body}");
    final errorKey = ErrorHandler.handleHttpStatusCode(httpResponse.statusCode);
    throw HttpRequestException(errorKey);
  }
}
