import 'package:flowers_app/Features/commerce/presentation/products/widgets/occasions/occasion_description.dart';
import 'package:flowers_app/core/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget createWidgetUnderTest() {
    return const MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: OccasionDescription(),
      ),
    );
  }

  group('OccasionDescription Widget Tests', () {
    testWidgets('Initial State: renders localized occasion description', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      final BuildContext context = tester.element(find.byType(OccasionDescription));
      expect(find.text(AppLocalizations.of(context)!.occasionDescription), findsOneWidget);
    });
  });
}
