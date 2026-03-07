import 'dart:convert';
 import 'package:flowers_app/Features/track_order/data/data_sources/remote/send_silent_notification_remot_data_source_imple.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';

import 'send_silent_notification_remot_data_source_imple_test.mocks.dart';


@GenerateMocks([http.Client])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late SendSilentNotificationDataSourceImple dataSource;
  late MockClient mockHttpClient;

    const tProjectId = "test-project-id";

   final mockServiceAccountJson = jsonEncode({
    "project_id": tProjectId,
    "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASC...\n-----END PRIVATE KEY-----\n",
    "client_email": "test@test.com",
    "token_uri": "https://oauth2.googleapis.com/token",
  });

  setUp(() {
    mockHttpClient = MockClient();
    dataSource = SendSilentNotificationDataSourceImple();

     TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMessageHandler('flutter/assets', (message) async {
      final Uint8List encoded = utf8.encoder.convert(mockServiceAccountJson);
      return encoded.buffer.asByteData();
    });
  });

  group('SendSilentNotificationDataSourceImple Tests', () {

    test(
      'should throw an exception when FCM returns a non-200 status code',
          () async {
       },
    );
  });
}