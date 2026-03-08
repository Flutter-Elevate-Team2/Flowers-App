import 'package:flowers_app/Features/commerce/presentation/products/widgets/shared/floating_button_content.dart';
import 'package:flowers_app/core/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget createWidgetUnderTest() {
    return const MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: FloatingButtonContent(),
      ),
    );
  }

  group('FloatingButtonContent Widget Tests', () {
    testWidgets('Initial State: renders correctly with icon and localized text', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.filter_list_rounded), findsOneWidget);
      
      final BuildContext context = tester.element(find.byType(FloatingButtonContent));
      final expectedText = AppLocalizations.of(context)!.filter;
      expect(find.text(expectedText), findsOneWidget);
    });

    testWidgets('Verify layout structure', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      
      expect(find.byType(FittedBox), findsOneWidget);
      expect(find.byType(Row), findsOneWidget);
    });
  });
}
