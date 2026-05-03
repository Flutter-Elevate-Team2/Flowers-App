import 'package:flowers_app/Features/order/presentation/cart/widgets/shared/add_to_cart_button/product_card_cart_style.dart';
 import 'package:flowers_app/Features/commerce/presentation/products/widgets/shared/product_card/product_card_add_to_cart_button.dart';
import 'package:flowers_app/Features/commerce/presentation/products/widgets/shared/product_card/product_quantity_selector.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
 import 'package:flowers_app/core/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late ProductCardCartStyle productCardCartStyle;

  setUp(() {
    productCardCartStyle = ProductCardCartStyle();
  });

  Widget createWidgetUnderTest(Widget child) {
    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en'), Locale('ar')],
      home: Scaffold(body: child),
    );
  }

  group('ProductCardCartStyle Tests', () {
    testWidgets('should build ProductCardAddToCartButton when buildAddButton is called', (tester) async {
      bool addTriggered = false;

      await tester.pumpWidget(createWidgetUnderTest(
        Builder(builder: (context) {
          return productCardCartStyle.buildAddButton(
            context,
            isLoading: false,
            onAdd: () => addTriggered = true,
          );
        }),
      ));

      // Assert that the specific custom widget is rendered
      expect(find.byType(ProductCardAddToCartButton), findsOneWidget);

      // Act
      await tester.tap(find.byType(ProductCardAddToCartButton));

      // Assert callback
      expect(addTriggered, isTrue);
    });

    testWidgets('should build ProductQuantitySelector when buildQuantitySelector is called', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest(
        Builder(builder: (context) {
          return productCardCartStyle.buildQuantitySelector(
            context,
            quantity: 5,
            isLoading: false,
            isIncrementDisabled: false,
            isDecrementDisabled: false,
            onIncrement: () {},
            onDecrement: () {},
            onDelete: () {},
          );
        }),
      ));

      // Assert correct widget and passed quantity
      expect(find.byType(ProductQuantitySelector), findsOneWidget);
      expect(find.text('5'), findsOneWidget);
    });

    testWidgets('should build a disabled ElevatedButton with Out of Stock text when buildSoldOut is called', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest(
        Builder(builder: (context) {
          return productCardCartStyle.buildSoldOut(context);
        }),
      ));

      // 1. Verify the button exists and is disabled
      final buttonFinder = find.byType(ElevatedButton);
      expect(buttonFinder, findsOneWidget);
      final ElevatedButton button = tester.widget(buttonFinder);
      expect(button.enabled, isFalse);

      // 2. Get the expected string from the same localization used in buildSoldOut
      // This ensures the test matches your actual ARB/Translation files
      late String expectedText;
      await tester.pumpWidget(createWidgetUnderTest(
        Builder(builder: (context) {
          expectedText = context.l10n.outOfStock;
          return productCardCartStyle.buildSoldOut(context);
        }),
      ));

      expect(find.text(expectedText), findsOneWidget);
    });
  });
}