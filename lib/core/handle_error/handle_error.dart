import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flowers_app/core/app_router/app_router.dart';
import 'package:flowers_app/core/constants/error_strings.dart';
import 'package:flowers_app/core/l10n/app_localizations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

class ErrorHandler {

  // === Helper Getter to access Localization Globally ===
  static AppLocalizations? get _l10n {
    final context = AppRouter.rootNavigatorKey.currentState?.context;
    if (context != null) {
      return AppLocalizations.of(context);
    }
    return null;
  }

  /// Main entry point.
  static String handleError(dynamic error) {
    debugPrint('🚨 ErrorHandler caught: ${error.runtimeType} -> $error');
    if (error is Error) {
      debugPrint('🚨 StackTrace: ${error.stackTrace}');
    }
    // -------------------------------------------------------------------------
    // SECTION 1: NETWORK & CONNECTION ERRORS
    // -------------------------------------------------------------------------
    if (error is DioException) {
      return _handleDioError(error);
    } else if (error is SocketException) {
      return _l10n?.noInternetError ?? ErrorStrings.noInternet;
    } else if (error is HandshakeException) {
      return _l10n?.badCertificateError ?? ErrorStrings.badCertificate;
    } else if (error is TimeoutException) {
      return _l10n?.connectionTimeoutError ?? ErrorStrings.connectionTimeout;
    }
    // -------------------------------------------------------------------------
    // SECTION 2: DATA & LOGIC ERRORS
    // -------------------------------------------------------------------------
    else if (error is TypeError) {
      return _l10n?.parsingError ?? ErrorStrings.parsingError;
    } else if (error is FormatException) {
      return _l10n?.formatExceptionError ?? ErrorStrings.formatException;
    }
    // -------------------------------------------------------------------------
    // SECTION 3: FIREBASE ERRORS
    // -------------------------------------------------------------------------
    else if (error is FirebaseAuthException) {
      return _handleFirebaseAuthError(error);
    } else if (error is FirebaseException) {
      return _handleFirebaseGeneralError(error);
    }
    // -------------------------------------------------------------------------
    // SECTION 4: LOCAL STORAGE ERRORS
    // -------------------------------------------------------------------------
    else if (error is HiveError) {
      return _l10n?.hiveError ?? ErrorStrings.hiveError;
    } else if (error is PlatformException) {
      return _handlePlatformError(error);
    }
    // -------------------------------------------------------------------------
    // SECTION 5: UNKNOWN / FALLBACK
    // -------------------------------------------------------------------------
    else {
      return _l10n?.unknownError ?? ErrorStrings.unknownError;
    }
  }

  // ===========================================================================
  // HELPER METHODS
  // ===========================================================================

  static String _handleDioError(DioException error) {
    return switch (error.type) {
      DioExceptionType.connectionTimeout => _l10n?.connectionTimeoutError ?? ErrorStrings.connectionTimeout,
      DioExceptionType.sendTimeout => _l10n?.sendTimeoutError ?? ErrorStrings.sendTimeout,
      DioExceptionType.receiveTimeout => _l10n?.receiveTimeoutError ?? ErrorStrings.receiveTimeout,
      DioExceptionType.badResponse => _handleBadResponse(error),
      DioExceptionType.cancel => _l10n?.requestCancelledError ?? ErrorStrings.requestCancelled,
      DioExceptionType.connectionError => _l10n?.connectionError ?? ErrorStrings.connectionError,
      DioExceptionType.badCertificate => _l10n?.badCertificateError ?? ErrorStrings.badCertificate,
      DioExceptionType.unknown => _handleUnknownError(error),
    };
  }

  static String _handleBadResponse(DioException error) {
    final statusCode = error.response?.statusCode;
    return switch (statusCode) {
      400 => _extractErrorMessage(error, _l10n?.badRequestError ?? ErrorStrings.badRequest),
      401 => _extractErrorMessage(error, _l10n?.unauthorizedError ?? ErrorStrings.unauthorized),
      403 => _l10n?.forbiddenError ?? ErrorStrings.forbidden,
      404 => _extractErrorMessage(error, _l10n?.notFoundError ?? ErrorStrings.notFound),
      409 => _extractErrorMessage(error, _l10n?.conflictError ?? ErrorStrings.conflict),

      500 => _l10n?.internalServerError ?? ErrorStrings.internalServerError,
      503 => _l10n?.serviceUnavailableError ?? ErrorStrings.serviceUnavailable,

      _ => _extractErrorMessage(error, _l10n?.defaultError ?? ErrorStrings.defaultError),
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
      return _l10n?.noInternetError ?? ErrorStrings.noInternet;
    }
    if (error.error is HandshakeException) {
      return _l10n?.badCertificateError ?? ErrorStrings.badCertificate;
    }

    final message = error.message ?? '';
    if (message.contains('SocketException')) {
      return _l10n?.noInternetError ?? ErrorStrings.noInternet;
    }
    return _l10n?.networkError ?? ErrorStrings.networkError;
  }

  static String _handleFirebaseAuthError(FirebaseAuthException error) {
    switch (error.code) {
      case 'user-not-found':
        return _l10n?.firebaseUserNotFound ?? ErrorStrings.firebaseUserNotFound;
      case 'wrong-password':
        return _l10n?.firebaseWrongPassword ?? ErrorStrings.firebaseWrongPassword;
      case 'email-already-in-use':
        return _l10n?.firebaseEmailInUse ?? ErrorStrings.firebaseEmailInUse;
      case 'invalid-email':
        return _l10n?.firebaseInvalidEmail ?? ErrorStrings.firebaseInvalidEmail;
      case 'weak-password':
        return _l10n?.firebaseWeakPassword ?? ErrorStrings.firebaseWeakPassword;
      case 'user-disabled':
        return _l10n?.firebaseAccountDisabled ?? ErrorStrings.firebaseAccountDisabled;
      case 'too-many-requests':
        return _l10n?.firebaseTooManyRequests ?? ErrorStrings.firebaseTooManyRequests;
      case 'network-request-failed':
        return _l10n?.noInternetError ?? ErrorStrings.noInternet;
      default:
        return error.message ?? _l10n?.firebaseAuthUnknown ?? ErrorStrings.firebaseAuthUnknown;
    }
  }

  static String _handleFirebaseGeneralError(FirebaseException error) {
    switch (error.code) {
      case 'permission-denied':
        return _l10n?.firebasePermissionDenied ?? ErrorStrings.firebasePermissionDenied;
      case 'unavailable':
        return _l10n?.firebaseUnavailable ?? ErrorStrings.firebaseUnavailable;
      case 'network-request-failed':
        return _l10n?.noInternetError ?? ErrorStrings.noInternet;
      default:
        return _l10n?.unknownError ?? ErrorStrings.unknownError;
    }
  }

  static String _handlePlatformError(PlatformException error) {
    if (error.code == 'network_error') {
      return _l10n?.noInternetError ?? ErrorStrings.noInternet;
    }
    return _l10n?.platformError ?? ErrorStrings.platformError;
  }
}