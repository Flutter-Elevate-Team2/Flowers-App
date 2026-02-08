import 'package:flowers_app/core/helpers/form_validators.dart';
import 'package:flowers_app/core/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget createTestWidget(Widget Function(BuildContext) builder) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Builder(builder: builder),
    );
  }

  group('FormValidators', () {
    testWidgets('validateEmail returns error for empty', (tester) async {
      String? result;
      await tester.pumpWidget(
        createTestWidget((context) {
          result = FormValidators.validateEmail(context, '');
          return const SizedBox();
        }),
      );

      expect(result, isNotNull); // Should have required error
    });

    testWidgets('validateEmail returns error for invalid format', (
      tester,
    ) async {
      String? result;
      await tester.pumpWidget(
        createTestWidget((context) {
          result = FormValidators.validateEmail(context, 'invalid-email');
          return const SizedBox();
        }),
      );

      expect(result, isNotNull); // Should have invalid error
    });

    testWidgets('validateEmail returns null for valid email', (tester) async {
      String? result;
      await tester.pumpWidget(
        createTestWidget((context) {
          result = FormValidators.validateEmail(context, 'test@example.com');
          return const SizedBox();
        }),
      );

      expect(result, isNull);
    });

    testWidgets('validatePassword returns error for weak password', (
      tester,
    ) async {
      String? result;
      await tester.pumpWidget(
        createTestWidget((context) {
          // Assume Regex requires specialized format (e.g. uppercase, number)
          // Testing a very simple password '123'
          result = FormValidators.validatePassword(context, '123');
          return const SizedBox();
        }),
      );

      expect(result, isNotNull);
    });

    testWidgets('validateRequired returns error for null', (tester) async {
      final result = FormValidators.validateRequired(null, 'Required');
      expect(result, 'Required');
    });
  });
}
