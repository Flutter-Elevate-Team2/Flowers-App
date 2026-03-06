import 'package:flowers_app/core/constants/error_strings.dart';
import 'package:flowers_app/core/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class ErrorMapper {
  static String mapError(BuildContext context, String errorKey) {
    final l10n = AppLocalizations.of(context);
    if (l10n == null) return _fallbackMessage(errorKey);

    // Try to map the key
    final mapped = _tryMapKey(l10n, errorKey);
    if (mapped != null) return mapped;

    // Check if it's a server message (not an error key)
    if (_isServerMessage(errorKey)) {
      return errorKey; // Display server message as-is
    }

    // Final fallback
    return l10n.unknownError;
  }

  static String? _tryMapKey(AppLocalizations l10n, String errorKey) {
    switch (errorKey) {
      // Network
      case ErrorStrings.noInternet:
        return l10n.noInternetError;
      case ErrorStrings.connectionTimeout:
        return l10n.connectionTimeoutError;
      case ErrorStrings.sendTimeout:
        return l10n.sendTimeoutError;
      case ErrorStrings.receiveTimeout:
        return l10n.receiveTimeoutError;
      case ErrorStrings.requestCancelled:
        return l10n.requestCancelledError;
      case ErrorStrings.badCertificate:
        return l10n.badCertificateError;
      case ErrorStrings.connectionError:
        return l10n.connectionError;
      case ErrorStrings.networkError:
        return l10n.networkError;

      // HTTP Codes
      case ErrorStrings.badRequest:
        return l10n.badRequestError;
      case ErrorStrings.unauthorized:
        return l10n.unauthorizedError;
      case ErrorStrings.forbidden:
        return l10n.forbiddenError;
      case ErrorStrings.notFound:
        return l10n.notFoundError;
      case ErrorStrings.conflict:
        return l10n.conflictError;
      case ErrorStrings.internalServerError:
        return l10n.internalServerError;
      case ErrorStrings.serviceUnavailable:
        return l10n.serviceUnavailableError;

      // Data & Parsing
      case ErrorStrings.parsingError:
        return l10n.parsingError;
      case ErrorStrings.formatException:
        return l10n.formatExceptionError;

      // Firebase
      case ErrorStrings.firebaseUserNotFound:
        return l10n.firebaseUserNotFound;
      case ErrorStrings.firebaseWrongPassword:
        return l10n.firebaseWrongPassword;
      case ErrorStrings.firebaseEmailInUse:
        return l10n.firebaseEmailInUse;
      case ErrorStrings.firebaseInvalidEmail:
        return l10n.firebaseInvalidEmail;
      case ErrorStrings.firebaseWeakPassword:
        return l10n.firebaseWeakPassword;
      case ErrorStrings.firebaseAccountDisabled:
        return l10n.firebaseAccountDisabled;
      case ErrorStrings.firebaseTooManyRequests:
        return l10n.firebaseTooManyRequests;
      case ErrorStrings.firebaseAuthUnknown:
        return l10n.firebaseAuthUnknown;
      case ErrorStrings.firebasePermissionDenied:
        return l10n.firebasePermissionDenied;
      case ErrorStrings.firebaseUnavailable:
        return l10n.firebaseUnavailable;
      case ErrorStrings.firebaseNotFound:
        return l10n.firebaseNotFound;

      // Others
      case ErrorStrings.hiveError:
        return l10n.hiveError;
      case ErrorStrings.platformError:
        return l10n.platformError;
      case ErrorStrings.defaultError:
        return l10n.defaultError;
      case ErrorStrings.unknownError:
        return l10n.unknownError;

      default:
        return null;
    }
  }

  static bool _isServerMessage(String text) {
    // Server messages are usually complete sentences
    return text.contains(' ') &&
        !text.startsWith('ERROR_') &&
        !text.contains('_');
  }

  static String _fallbackMessage(String key) {
    // English fallback messages
    const fallbacks = {
      ErrorStrings.noInternet: 'No internet connection',
      ErrorStrings.connectionTimeout: 'Connection timeout',
      ErrorStrings.unauthorized: 'Unauthorized access',
      ErrorStrings.notFound: 'Resource not found',
      ErrorStrings.internalServerError: 'Server error',
    };
    return fallbacks[key] ?? 'An error occurred. Please try again.';
  }
}
