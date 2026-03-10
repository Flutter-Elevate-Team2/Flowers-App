import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flowers_app/core/app_router/app_router.dart';
import 'package:flowers_app/core/constants/app_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  if (kDebugMode) {
    print('Handling a background message: ${message.messageId}');
  }
}

class PushNotificationService {
  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin
  _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  // StreamController to broadcast notification events
  static final StreamController<void> _notificationStreamController =
      StreamController.broadcast();
  static Stream<void> get onNotificationReceived =>
      _notificationStreamController.stream;

  static String? _deviceToken;
  static String? get deviceToken => _deviceToken;

  static Future<void> init() async {
    await _requestPermission();
    await _initLocalNotifications();
    await _getDeviceToken();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (kDebugMode) {
        print('Got a message whilst in the foreground!');
        print('Message data: ${message.data}');
      }

      if (message.notification != null) {
        if (kDebugMode) {
          print(
            'Message also contained a notification: ${message.notification}',
          );
        }
        _showLocalNotification(message);
        _notificationStreamController.add(null); // Notify listeners
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (kDebugMode) {
        print('A new onMessageOpenedApp event was published!');
      }
      _notificationStreamController.add(null); // Notify listeners
      _handleNotificationRouting(message.data);
    });
  }

  static void _handleNotificationRouting(Map<String, dynamic> data) {
    if (kDebugMode) {
      print('Handling notification routing: $data');
    }
    final orderId = data['orderId'];
    if (orderId != null && orderId.toString().isNotEmpty) {
      AppRouter.router.pushNamed(
        Routes.trackOrderName,
        pathParameters: {'orderId': orderId.toString()},
      );
    }
  }

  static Future<void> _requestPermission() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (kDebugMode) {
      print('User granted permission: ${settings.authorizationStatus}');
    }
  }

  static Future<void> _getDeviceToken() async {
    String? token;
    if (Platform.isIOS) {
      token = await _firebaseMessaging.getAPNSToken();
    } else {
      token = await _firebaseMessaging.getToken();
    }

    _deviceToken = token;

    if (kDebugMode) {
      print('Device Token: $token');
    }
  }

  static Future<void> _initLocalNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@drawable/ic_notification');

    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
          requestAlertPermission: false,
          requestBadgePermission: false,
          requestSoundPermission: false,
        );

    final InitializationSettings initializationSettings =
        InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsDarwin,
        );

    await _flutterLocalNotificationsPlugin.initialize(
      settings: initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) {
            if (notificationResponse.payload != null) {
              try {
                final data =
                    jsonDecode(notificationResponse.payload!)
                        as Map<String, dynamic>;
                _handleNotificationRouting(data);
              } catch (e) {
                if (kDebugMode) print('Error decoding payload: $e');
              }
            }
          },
    );
  }

  static Future<void> _showLocalNotification(RemoteMessage message) async {
    final prefs = await SharedPreferences.getInstance();
    final isNotificationsEnabled =
        prefs.getBool('is_notifications_enabled') ?? true;

    if (!isNotificationsEnabled) {
      if (kDebugMode) {
        print('Local notifications are disabled in user preferences.');
      }
      return;
    }

    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification != null && android != null) {
      await _flutterLocalNotificationsPlugin.show(
        id: notification.hashCode,
        title: notification.title,
        body: notification.body,
        notificationDetails: NotificationDetails(
          android: AndroidNotificationDetails(
            'high_importance_channel',
            'High Importance Notifications',
            channelDescription:
                'This channel is used for important notifications.',
            importance: Importance.max,
            priority: Priority.high,
            icon: '@drawable/ic_notification',
            color: AppColors.mainColor,
          ),
          iOS: DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        payload: jsonEncode(message.data),
      );
    }
  }
}
