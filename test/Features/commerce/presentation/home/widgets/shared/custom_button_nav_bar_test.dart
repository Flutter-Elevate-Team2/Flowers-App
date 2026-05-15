import 'package:flowers_app/Features/commerce/presentation/home/widgets/shared/custom_button_nav_bar.dart';
import 'package:flowers_app/core/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget createWidgetUnderTest({
    required int currentIndex,
    required ValueChanged<int> onTap,
  }) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        bottomNavigationBar: CustomButtonNavigationBar(
          currentIndex: currentIndex,
          onTap: onTap,
        ),
      ),
    );
  }

  group('CustomButtonNavigationBar Tests', () {
    testWidgets('renders correctly with all items and translations', (
      tester,
    ) async {
      await tester.pumpWidget(
        createWidgetUnderTest(currentIndex: 0, onTap: (_) {}),
      );
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.home_outlined), findsOneWidget);
      expect(find.byIcon(Icons.category_outlined), findsOneWidget);
      expect(find.byIcon(Icons.shopping_cart_outlined), findsOneWidget);
      expect(find.byIcon(Icons.person_outline), findsOneWidget);

      expect(find.text('Home'), findsWidgets);
      expect(find.text('Categories'), findsWidgets);
    });

    testWidgets('calls onTap with correct index when an item is pressed', (
      tester,
    ) async {
      int capturedIndex = -1;

      await tester.pumpWidget(
        createWidgetUnderTest(
          currentIndex: 0,
          onTap: (index) {
            capturedIndex = index;
          },
        ),
      );

      await tester.tap(find.byIcon(Icons.category_outlined));
      await tester.pump();

      expect(capturedIndex, 1);

      await tester.tap(find.byIcon(Icons.person_outline));
      await tester.pump();

      expect(capturedIndex, 3);
    });

    testWidgets('reflects the currentIndex correctly', (tester) async {
      const activeIndex = 2; // Cart

      await tester.pumpWidget(
        createWidgetUnderTest(currentIndex: activeIndex, onTap: (_) {}),
      );

      final BottomNavigationBar navBar = tester.widget(
        find.byType(BottomNavigationBar),
      );
      expect(navBar.currentIndex, activeIndex);
    });
  });
}
