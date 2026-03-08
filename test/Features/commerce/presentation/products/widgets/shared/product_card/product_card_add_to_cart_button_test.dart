import 'package:flowers_app/Features/commerce/presentation/products/widgets/shared/product_card/product_card_add_to_cart_button.dart';
import 'package:flowers_app/core/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget createWidgetUnderTest({VoidCallback? onAddToCart, bool isLoading = false}) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: ProductCardAddToCartButton(
          onAddToCart: onAddToCart,
          isLoading: isLoading,
        ),
      ),
    );
  }

  group('ProductCardAddToCartButton Widget Tests', () {
    testWidgets('Initial State: renders add to cart text and icon', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      final BuildContext context = tester.element(find.byType(ProductCardAddToCartButton));
      expect(find.text(AppLocalizations.of(context)!.addToCart), findsOneWidget);
      expect(find.byIcon(Icons.shopping_cart_outlined), findsOneWidget);
    });

    testWidgets('Loading State: shows CircularProgressIndicator when isLoading is true', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest(isLoading: true));
      // No need to pumpAndSettle as AnimatedSwitcher might be mid-transition
      await tester.pump(const Duration(milliseconds: 200));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.byIcon(Icons.shopping_cart_outlined), findsNothing);
    });

    testWidgets('Interaction: calls onAddToCart when button is pressed and not loading', (tester) async {
      bool called = false;
      await tester.pumpWidget(createWidgetUnderTest(onAddToCart: () => called = true));

      await tester.tap(find.byType(ElevatedButton));
      expect(called, isTrue);
    });

    testWidgets('Interaction: does not call onAddToCart when isLoading is true', (tester) async {
      bool called = false;
      await tester.pumpWidget(createWidgetUnderTest(
        onAddToCart: () => called = true,
        isLoading: true,
      ));

      await tester.tap(find.byType(ElevatedButton));
      expect(called, isFalse);
    });
  });
}
