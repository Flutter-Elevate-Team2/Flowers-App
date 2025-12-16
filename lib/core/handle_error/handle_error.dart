import 'dart:async'; // For TimeoutException
import 'dart:io';    // For SocketException & HandshakeException

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart'; // For PlatformException
import 'package:hive/hive.dart';

// Ensure this path matches your project structure
import 'package:flowers_app/core/constants/app_error_messages.dart';

class ErrorHandler {

  /// The main entry point to handle all types of errors in the application.
  static String handleError(dynamic error) {

    // -------------------------------------------------------------------------
    // SECTION 1: NETWORK & CONNECTION ERRORS
    // -------------------------------------------------------------------------
    if (error is DioException) {
      return _handleDioError(error); // Detailed Dio error handling
    }
    else if (error is SocketException) {
      return AppErrorMessages.noInternetError; // No Internet (Raw Dart Error)
    }
    else if (error is HandshakeException) {
      return AppErrorMessages.badCertificateError; // SSL/Security Certificate issue
    }
    else if (error is TimeoutException) {
      return AppErrorMessages.connectionTimeoutError; // Operation timed out
    }

    // -------------------------------------------------------------------------
    // SECTION 2: DATA & LOGIC ERRORS
    // -------------------------------------------------------------------------
    else if (error is TypeError) {
      // Occurs when data type differs from expected (e.g., String instead of int)
      return AppErrorMessages.parsingError;
    }
    else if (error is FormatException) {
      // Occurs when there is a data formatting error (e.g., Malformed JSON)
      return AppErrorMessages.formatExceptionError;
    }

    // -------------------------------------------------------------------------
    // SECTION 3: FIREBASE ERRORS
    // -------------------------------------------------------------------------
    else if (error is FirebaseAuthException) {
      return _handleFirebaseAuthError(error); // Authentication errors
    }
    else if (error is FirebaseException) {
      return _handleFirebaseGeneralError(error); // General Firebase errors (Firestore/Storage)
    }

    // -------------------------------------------------------------------------
    // SECTION 4: LOCAL STORAGE ERRORS
    // -------------------------------------------------------------------------
    else if (error is HiveError) {
      return _handleHiveError(error); // Hive Database errors
    }
    else if (error is PlatformException) {
      return _handlePlatformError(error); // SharedPrefs or System/Platform errors
    }

    // -------------------------------------------------------------------------
    // SECTION 5: UNKNOWN / FALLBACK
    // -------------------------------------------------------------------------
    else {
      return AppErrorMessages.unknownError;
    }
  }

  // ===========================================================================
  // HELPER METHODS
  // ===========================================================================

  // -----------------------
  // 1. Dio Helper
  // -----------------------
  static String _handleDioError(DioException error) {
    return switch (error.type) {
      DioExceptionType.connectionTimeout => AppErrorMessages.connectionTimeoutError,
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

  /// Tries to extract the error message from the response body.
  /// If it fails, it returns the default message.
  static String _extractErrorMessage(DioException error, String defaultMessage) {
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
    // Check if the underlying error is a SocketException
    if (error.error is SocketException) {
      return AppErrorMessages.noInternetError;
    }
    // Check if the underlying error is a HandshakeException
    if (error.error is HandshakeException) {
      return AppErrorMessages.badCertificateError;
    }

    final message = error.message ?? '';
    // Final check on the message string
    if (message.contains('SocketException')) {
      return AppErrorMessages.noInternetError;
    }
    return AppErrorMessages.networkError;
  }

  // -----------------------
  // 2. Firebase Auth Helper
  // -----------------------
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

  // -----------------------
  // 3. Firebase General Helper
  // -----------------------
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

  // -----------------------
  // 4. Hive Helper
  // -----------------------
  static String _handleHiveError(HiveError error) {
    return AppErrorMessages.hiveError;
  }

  // -----------------------
  // 5. Platform/SharedPrefs Helper
  // -----------------------
  static String _handlePlatformError(PlatformException error) {
    if (error.code == 'network_error') {
      return AppErrorMessages.noInternetError;
    }
    return AppErrorMessages.platformError;
  }
}
