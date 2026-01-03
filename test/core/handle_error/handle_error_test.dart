import 'dart:io';
import 'dart:async';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flowers_app/core/constants/error_strings.dart';
import 'package:flowers_app/core/handle_error/handle_error.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ErrorHandler Logic & Fallback Tests', () {

    // =========================================================
    // 1. Network & Socket Errors
    // =========================================================
    test('should return ErrorStrings.noInternet when SocketException occurs', () {
      final error = SocketException('No internet');
      final result = ErrorHandler.handleError(error);
      expect(result, ErrorStrings.noInternet);
    });

    test('should return ErrorStrings.connectionTimeout when TimeoutException occurs', () {
      final error = TimeoutException('Time out');
      final result = ErrorHandler.handleError(error);
      expect(result, ErrorStrings.connectionTimeout);
    });

    test('should return ErrorStrings.badCertificate when HandshakeException occurs', () {
      final error = HandshakeException('Bad cert');
      final result = ErrorHandler.handleError(error);
      expect(result, ErrorStrings.badCertificate);
    });

    // =========================================================
    // 2. Dio HTTP Errors
    // =========================================================
    group('DioException Tests', () {
      test('should return unauthorized string for 401', () {
        final error = DioException(
          requestOptions: RequestOptions(),
          type: DioExceptionType.badResponse,
          response: Response(
            requestOptions: RequestOptions(),
            statusCode: 401,
            data: {'message': 'Unauthorized'},
          ),
        );
        final result = ErrorHandler.handleError(error);
        expect(result, contains('Unauthorized'));
      });

      test('should return notFound string for 404', () {
        final error = DioException(
          requestOptions: RequestOptions(),
          type: DioExceptionType.badResponse,
          response: Response(
            requestOptions: RequestOptions(),
            statusCode: 404,
          ),
        );
        final result = ErrorHandler.handleError(error);
        expect(result, ErrorStrings.notFound);
      });

      test('should return internalServerError for 500', () {
        final error = DioException(
          requestOptions: RequestOptions(),
          type: DioExceptionType.badResponse,
          response: Response(
            requestOptions: RequestOptions(),
            statusCode: 500,
          ),
        );
        final result = ErrorHandler.handleError(error);
        expect(result, ErrorStrings.internalServerError);
      });

      test('should return connectionTimeout for Dio connection timeout type', () {
        final error = DioException(
          requestOptions: RequestOptions(),
          type: DioExceptionType.connectionTimeout,
        );
        final result = ErrorHandler.handleError(error);
        expect(result, ErrorStrings.connectionTimeout);
      });
    });

    // =========================================================
    // 3. Firebase Auth Errors
    // =========================================================
    group('FirebaseAuthException Tests', () {
      test('should return firebaseUserNotFound for user-not-found code', () {
        final error = FirebaseAuthException(code: 'user-not-found');
        final result = ErrorHandler.handleError(error);
        expect(result, ErrorStrings.firebaseUserNotFound);
      });

      test('should return firebaseEmailInUse for email-already-in-use code', () {
        final error = FirebaseAuthException(code: 'email-already-in-use');
        final result = ErrorHandler.handleError(error);
        expect(result, ErrorStrings.firebaseEmailInUse);
      });

      test('should return firebaseWeakPassword for weak-password code', () {
        final error = FirebaseAuthException(code: 'weak-password');
        final result = ErrorHandler.handleError(error);
        expect(result, ErrorStrings.firebaseWeakPassword);
      });

      test('should return noInternet for network-request-failed code', () {
        final error = FirebaseAuthException(code: 'network-request-failed');
        final result = ErrorHandler.handleError(error);
        expect(result, ErrorStrings.noInternet);
      });
    });

    // =========================================================
    // 4. Firebase General Errors
    // =========================================================
    group('FirebaseException Tests', () {
      test('should return firebasePermissionDenied for permission-denied', () {
        final error = FirebaseException(plugin: 'firestore', code: 'permission-denied');
        final result = ErrorHandler.handleError(error);
        expect(result, ErrorStrings.firebasePermissionDenied);
      });

      test('should return firebaseUnavailable for unavailable', () {
        final error = FirebaseException(plugin: 'firestore', code: 'unavailable');
        final result = ErrorHandler.handleError(error);
        expect(result, ErrorStrings.firebaseUnavailable);
      });
    });

    // =========================================================
    // 5. Platform & Generic Errors
    // =========================================================
    test('should return platformError for general PlatformException', () {
      final error = PlatformException(code: 'some_error');
      final result = ErrorHandler.handleError(error);
      expect(result, ErrorStrings.platformError);
    });

    test('should return noInternet for network_error PlatformException', () {
      final error = PlatformException(code: 'network_error');
      final result = ErrorHandler.handleError(error);
      expect(result, ErrorStrings.noInternet);
    });

    test('should return unknownError for generic Exception', () {
      final error = Exception('Random error');
      final result = ErrorHandler.handleError(error);
      expect(result, ErrorStrings.unknownError);
    });
  });
}
