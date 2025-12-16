import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flowers_app/core/constants/app_error_messages.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

class ErrorHandler {
  static String handleError(dynamic error) {
    if (error is DioException) {
      return _handleDioError(error);
    } else if (error is SocketException) {
      return AppErrorMessages.noInternetError;
    } else if (error is HandshakeException) {
      return AppErrorMessages.badCertificateError;
    } else if (error is FirebaseAuthException) {
      return _handleFirebaseAuthError(error);
    } else if (error is FirebaseException) {
      return _handleFirebaseGeneralError(error);
    } else if (error is HiveError) {
      return _handleHiveError(error);
    } else if (error is PlatformException) {
      return _handlePlatformError(error);
    } else if (error is FormatException) {
      return AppErrorMessages.formatExceptionError;
    } else {
      return AppErrorMessages.unknownError;
    }
  }

  // ================= DIO HANDLER =================
  static String _handleDioError(DioException error) {
    return switch (error.type) {
      DioExceptionType.connectionTimeout =>
        AppErrorMessages.connectionTimeoutError,
      DioExceptionType.sendTimeout => AppErrorMessages.sendTimeoutError,
      DioExceptionType.receiveTimeout => AppErrorMessages.receiveTimeoutError,
      DioExceptionType.badResponse => _handleBadResponse(error),
      DioExceptionType.cancel => AppErrorMessages.requestCancelledError,
      DioExceptionType.connectionError => AppErrorMessages.connectionError,
      DioExceptionType.badCertificate => AppErrorMessages.badCertificateError,
      DioExceptionType.unknown => _handleUnknownError(error),
    };
  }

  static String _handleBadResponse(DioException error) {
    final statusCode = error.response?.statusCode;
    return switch (statusCode) {
      400 => _extractErrorMessage(error, AppErrorMessages.badRequestError),
      401 => _extractErrorMessage(error, AppErrorMessages.unauthorizedError),
      403 => AppErrorMessages.forbiddenError,
      404 => AppErrorMessages.notFoundError,
      409 => AppErrorMessages.conflictError,
      500 => AppErrorMessages.internalServerError,
      503 => AppErrorMessages.serviceUnavailableError,
      _ => _extractErrorMessage(error, AppErrorMessages.defaultError),
    };
  }

  static String _extractErrorMessage(
    DioException error,
    String defaultMessage,
  ) {
    try {
      final data = error.response?.data;
      if (data is Map<String, dynamic>) {
        return data['message']?.toString() ??
            data['error']?.toString() ??
            defaultMessage;
      }
      return defaultMessage;
    } catch (e) {
      return defaultMessage;
    }
  }

  static String _handleUnknownError(DioException error) {
    if (error.error is SocketException) {
      return AppErrorMessages.noInternetError;
    }
    if (error.error is HandshakeException) {
      return AppErrorMessages.badCertificateError;
    }

    final message = error.message ?? '';
    if (message.contains('SocketException')) {
      return AppErrorMessages.noInternetError;
    }

    return AppErrorMessages.networkError;
  }

  // ================= FIREBASE AUTH HANDLER =================
  static String _handleFirebaseAuthError(FirebaseAuthException error) {
    switch (error.code) {
      case 'user-not-found':
        return AppErrorMessages.firebaseUserNotFound;
      case 'wrong-password':
        return AppErrorMessages.firebaseWrongPassword;
      case 'email-already-in-use':
        return AppErrorMessages.firebaseEmailInUse;
      case 'invalid-email':
        return AppErrorMessages.firebaseInvalidEmail;
      case 'weak-password':
        return AppErrorMessages.firebaseWeakPassword;
      case 'user-disabled':
        return AppErrorMessages.firebaseAccountDisabled;
      case 'too-many-requests':
        return AppErrorMessages.firebaseTooManyRequests;
      case 'network-request-failed':
        return AppErrorMessages.noInternetError;
      default:
        return error.message ?? AppErrorMessages.firebaseAuthUnknown;
    }
  }

  // ================= FIREBASE GENERAL HANDLER =================
  static String _handleFirebaseGeneralError(FirebaseException error) {
    switch (error.code) {
      case 'permission-denied':
        return AppErrorMessages.firebasePermissionDenied;
      case 'unavailable':
        return AppErrorMessages.firebaseUnavailable;
      case 'network-request-failed':
        return AppErrorMessages.noInternetError;
      default:
        return AppErrorMessages.unknownError;
    }
  }

  // ================= HIVE HANDLER =================
  static String _handleHiveError(HiveError error) {
    return AppErrorMessages.hiveError;
  }

  // ================= SHARED PREFERENCES (PLATFORM) HANDLER =================
  static String _handlePlatformError(PlatformException error) {
    if (error.code == 'network_error') {
      return AppErrorMessages.noInternetError;
    }
    return AppErrorMessages.platformError;
  }
}
