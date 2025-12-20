import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flowers_app/core/l10n/app_localizations.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';


class ErrorHandler {

  /// The main entry point to handle all types of errors in the application.
  /// Requires [BuildContext] to retrieve localized error messages.
  static String handleError(BuildContext context, dynamic error) {

    final strings = AppLocalizations.of(context)!;

    // -------------------------------------------------------------------------
    // SECTION 1: NETWORK & CONNECTION ERRORS
    // -------------------------------------------------------------------------
    if (error is DioException) {
      return _handleDioError(strings, error); // Detailed Dio error handling
    }
    else if (error is SocketException) {
      return strings.noInternetError; // No Internet (Raw Dart Error)
    }
    else if (error is HandshakeException) {
      return strings.badCertificateError; // SSL/Security Certificate issue
    }
    else if (error is TimeoutException) {
      return strings.connectionTimeoutError; // Operation timed out
    }

    // -------------------------------------------------------------------------
    // SECTION 2: DATA & LOGIC ERRORS
    // -------------------------------------------------------------------------
    else if (error is TypeError) {
      // Occurs when data type differs from expected (e.g., String instead of int)
      return strings.parsingError;
    }
    else if (error is FormatException) {
      // Occurs when there is a data formatting error (e.g., Malformed JSON)
      return strings.formatExceptionError;
    }

    // -------------------------------------------------------------------------
    // SECTION 3: FIREBASE ERRORS
    // -------------------------------------------------------------------------
    else if (error is FirebaseAuthException) {
      return _handleFirebaseAuthError(strings, error); // Authentication errors
    }
    else if (error is FirebaseException) {
      return _handleFirebaseGeneralError(strings, error); // General Firebase errors (Firestore/Storage)
    }

    // -------------------------------------------------------------------------
    // SECTION 4: LOCAL STORAGE ERRORS
    // -------------------------------------------------------------------------
    else if (error is HiveError) {
      return _handleHiveError(strings, error); // Hive Database errors
    }
    else if (error is PlatformException) {
      return _handlePlatformError(strings, error); // SharedPrefs or System/Platform errors
    }

    // -------------------------------------------------------------------------
    // SECTION 5: UNKNOWN / FALLBACK
    // -------------------------------------------------------------------------
    else {
      return strings.unknownError;
    }
  }

  // ===========================================================================
  // HELPER METHODS
  // ===========================================================================

  // -----------------------
  // 1. Dio Helper
  // -----------------------
  static String _handleDioError(AppLocalizations strings, DioException error) {
    return switch (error.type) {
      DioExceptionType.connectionTimeout => strings.connectionTimeoutError,
      DioExceptionType.sendTimeout => strings.sendTimeoutError,
      DioExceptionType.receiveTimeout => strings.receiveTimeoutError,
      DioExceptionType.badResponse => _handleBadResponse(strings, error),
      DioExceptionType.cancel => strings.requestCancelledError,
      DioExceptionType.connectionError => strings.connectionError,
      DioExceptionType.badCertificate => strings.badCertificateError,
      DioExceptionType.unknown => _handleUnknownError(strings, error),
    };
  }

  static String _handleBadResponse(AppLocalizations strings, DioException error) {
    final statusCode = error.response?.statusCode;
    return switch (statusCode) {
      400 => _extractErrorMessage(error, strings.badRequestError),
      401 => _extractErrorMessage(error, strings.unauthorizedError),
      403 => strings.forbiddenError,
      404 => strings.notFoundError,
      409 => strings.conflictError,
      500 => strings.internalServerError,
      503 => strings.serviceUnavailableError,
      _ => _extractErrorMessage(error, strings.defaultError),
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

  static String _handleUnknownError(AppLocalizations strings, DioException error) {
    // Check if the underlying error is a SocketException
    if (error.error is SocketException) {
      return strings.noInternetError;
    }
    // Check if the underlying error is a HandshakeException
    if (error.error is HandshakeException) {
      return strings.badCertificateError;
    }

    final message = error.message ?? '';
    // Final check on the message string
    if (message.contains('SocketException')) {
      return strings.noInternetError;
    }
    return strings.networkError;
  }

  // -----------------------
  // 2. Firebase Auth Helper
  // -----------------------
  static String _handleFirebaseAuthError(AppLocalizations strings, FirebaseAuthException error) {
    switch (error.code) {
      case 'user-not-found':
        return strings.firebaseUserNotFound;
      case 'wrong-password':
        return strings.firebaseWrongPassword;
      case 'email-already-in-use':
        return strings.firebaseEmailInUse;
      case 'invalid-email':
        return strings.firebaseInvalidEmail;
      case 'weak-password':
        return strings.firebaseWeakPassword;
      case 'user-disabled':
        return strings.firebaseAccountDisabled;
      case 'too-many-requests':
        return strings.firebaseTooManyRequests;
      case 'network-request-failed':
        return strings.noInternetError;
      default:
        return error.message ?? strings.firebaseAuthUnknown;
    }
  }

  // -----------------------
  // 3. Firebase General Helper
  // -----------------------
  static String _handleFirebaseGeneralError(AppLocalizations strings, FirebaseException error) {
    switch (error.code) {
      case 'permission-denied':
        return strings.firebasePermissionDenied;
      case 'unavailable':
        return strings.firebaseUnavailable;
      case 'network-request-failed':
        return strings.noInternetError;
      default:
        return strings.unknownError;
    }
  }

  // -----------------------
  // 4. Hive Helper
  // -----------------------
  static String _handleHiveError(AppLocalizations strings, HiveError error) {
    return strings.hiveError;
  }

  // -----------------------
  // 5. Platform/SharedPrefs Helper
  // -----------------------
  static String _handlePlatformError(AppLocalizations strings, PlatformException error) {
    if (error.code == 'network_error') {
      return strings.noInternetError;
    }
    return strings.platformError;
  }
}
