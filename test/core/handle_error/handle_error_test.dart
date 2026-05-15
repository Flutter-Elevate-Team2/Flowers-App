 import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flowers_app/core/constants/error_strings.dart';
 import 'package:flowers_app/core/handle_error/handle_error.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';

void main() {
  group('ErrorHandler Unit Tests', () {

    // --- اختبارات Dio (الشبكة) ---
    test('يجب أن يعيد connectionTimeout عند حدوث DioException من نوع connectionTimeout', () {
      final error = DioException(
        requestOptions: RequestOptions(),
        type: DioExceptionType.connectionTimeout,
      );

      final result = ErrorHandler.handleError(error);

      expect(result, ErrorStrings.connectionTimeout);
    });

    test('يجب أن يستخرج رسالة الخطأ من استجابة السيرفر (400 Bad Request)', () {
      final error = DioException(
        requestOptions: RequestOptions(),
        type: DioExceptionType.badResponse,
        response: Response(
          requestOptions: RequestOptions(),
          statusCode: 400,
          data: {'message': 'Custom Server Error'},
        ),
      );

      final result = ErrorHandler.handleError(error);

      expect(result, 'Custom Server Error');
    });

    // --- اختبارات Firebase ---
    test('يجب أن يعيد firebaseUserNotFound عند حدوث FirebaseAuthException بكود user-not-found', () {
      final error = FirebaseAuthException(code: 'user-not-found');

      final result = ErrorHandler.handleError(error);

      expect(result, ErrorStrings.firebaseUserNotFound);
    });

    // --- اختبارات الاستثناءات العامة (Core Exceptions) ---
    test('يجب أن يعيد noInternet عند حدوث SocketException', () {
      const error = SocketException('No Network');

      final result = ErrorHandler.handleError(error);

      expect(result, ErrorStrings.noInternet);
    });

    test('يجب أن يعيد parsingError عند حدوث TypeError', () {
      final error = TypeError();

      final result = ErrorHandler.handleError(error);

      expect(result, ErrorStrings.parsingError);
    });

    // --- اختبارات Hive و Platform ---
    test('يجب أن يعيد hiveError عند حدوث HiveError', () {
      final error = HiveError('Database Corrupted');

      final result = ErrorHandler.handleError(error);

      expect(result, ErrorStrings.hiveError);
    });

    test('يجب أن يعيد platformError عند حدوث PlatformException عشوائي', () {
      final error = PlatformException(code: 'UNKNOWN_CODE');

      final result = ErrorHandler.handleError(error);

      expect(result, ErrorStrings.platformError);
    });

    // --- اختبارات Fallback ---
    test('يجب أن يعيد unknownError لأي خطأ غير معرف', () {
      final error = Exception('Some generic error');

      final result = ErrorHandler.handleError(error);

      expect(result, ErrorStrings.unknownError);
    });

    // --- اختبار دالة HttpStatusCode (لـ package:http) ---
    test('يجب أن تعيد internalServerError للكود 500', () {
      final result = ErrorHandler.handleHttpStatusCode(500);
      expect(result, ErrorStrings.internalServerError);
    });
  });
}