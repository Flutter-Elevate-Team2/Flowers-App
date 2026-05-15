import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flowers_app/core/l10n/app_localizations.dart';

void main() {
  testWidgets('LocalizationExtension.l10n returns AppLocalizations', (
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

    expect(capturedContext.l10n, isA<AppLocalizations>());
  });
}
