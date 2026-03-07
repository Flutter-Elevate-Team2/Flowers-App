import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flowers_app/core/constants/error_strings.dart';
import 'package:flowers_app/core/helpers/error_mapper.dart';
import 'package:flowers_app/core/l10n/app_localizations.dart';

void main() {
  group('ErrorMapper - Full Coverage (100%)', () {
    testWidgets('should map EVERY ErrorString to its localization', (
      tester,
    ) async {
      late BuildContext capturedContext;
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: const Locale('en'),
          home: Builder(
            builder: (context) {
              capturedContext = context;
              return const SizedBox();
            },
          ),
        ),
      );
      await tester.pumpAndSettle();
      final l10n = AppLocalizations.of(capturedContext)!;

      final allKeys = [
        ErrorStrings.noInternet,
        ErrorStrings.connectionTimeout,
        ErrorStrings.sendTimeout,
        ErrorStrings.receiveTimeout,
        ErrorStrings.requestCancelled,
        ErrorStrings.badCertificate,
        ErrorStrings.connectionError,
        ErrorStrings.networkError,
        ErrorStrings.badRequest,
        ErrorStrings.unauthorized,
        ErrorStrings.forbidden,
        ErrorStrings.notFound,
        ErrorStrings.conflict,
        ErrorStrings.internalServerError,
        ErrorStrings.serviceUnavailable,
        ErrorStrings.parsingError,
        ErrorStrings.formatException,
        ErrorStrings.firebaseUserNotFound,
        ErrorStrings.firebaseWrongPassword,
        ErrorStrings.firebaseEmailInUse,
        ErrorStrings.firebaseInvalidEmail,
        ErrorStrings.firebaseWeakPassword,
        ErrorStrings.firebaseAccountDisabled,
        ErrorStrings.firebaseTooManyRequests,
        ErrorStrings.firebaseAuthUnknown,
        ErrorStrings.firebasePermissionDenied,
        ErrorStrings.firebaseUnavailable,
        ErrorStrings.hiveError,
        ErrorStrings.platformError,
        ErrorStrings.defaultError,
        ErrorStrings.unknownError,
      ];

      for (var key in allKeys) {
        final result = ErrorMapper.mapError(capturedContext, key);
        if (key != ErrorStrings.unknownError) {
          expect(
            result,
            isNot(l10n.unknownError),
            reason: 'Failed to map key: $key',
          );
        }
        expect(result, isA<String>());
      }
    });

    testWidgets('should cover _fallbackMessage when l10n is missing', (
      tester,
    ) async {
      late BuildContext capturedContext;
      await tester.pumpWidget(
        MaterialApp(home: Builder(builder: (context) => const SizedBox())),
      );
      capturedContext = tester.element(find.byType(SizedBox));

      expect(
        ErrorMapper.mapError(capturedContext, ErrorStrings.noInternet),
        'No internet connection',
      );
      expect(
        ErrorMapper.mapError(capturedContext, ErrorStrings.notFound),
        'Resource not found',
      );

      expect(
        ErrorMapper.mapError(capturedContext, 'RANDOM_KEY'),
        'An error occurred. Please try again.',
      );
    });

    testWidgets('should cover _isServerMessage logic and default null case', (
      tester,
    ) async {
      late BuildContext capturedContext;
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Builder(
            builder: (context) {
              capturedContext = context;
              return const SizedBox();
            },
          ),
        ),
      );
      await tester.pumpAndSettle();
      final l10n = AppLocalizations.of(capturedContext)!;

      const serverMsg = 'This is a custom message from backend';
      expect(ErrorMapper.mapError(capturedContext, serverMsg), serverMsg);

      expect(
        ErrorMapper.mapError(capturedContext, 'Something'),
        l10n.unknownError,
      );
    });
  });
}
