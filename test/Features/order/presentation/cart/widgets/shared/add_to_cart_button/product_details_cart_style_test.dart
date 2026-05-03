 import 'package:flowers_app/Features/commerce/presentation/products/widgets/shared/product_card/product_quantity_selector.dart';
import 'package:flowers_app/Features/order/presentation/cart/widgets/shared/add_to_cart_button/product_details_cart_style.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flowers_app/core/l10n/app_localizations.dart';
 import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late ProductDetailsCartStyle detailsStyle;

  setUp(() {
    detailsStyle = ProductDetailsCartStyle();
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

  group('ProductDetailsCartStyle Tests', () {

    testWidgets('should show CircularProgressIndicator in Add button when isLoading is true', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest(
        Builder(builder: (context) => detailsStyle.buildAddButton(
          context,
          isLoading: true,
          onAdd: () {},
        )),
      ));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // Verify button is disabled when loading
      final ElevatedButton button = tester.widget(find.byType(ElevatedButton));
      expect(button.enabled, isFalse);
    });

    testWidgets('should call onAdd when Add button is pressed and not loading', (tester) async {
      bool addCalled = false;

      await tester.pumpWidget(createWidgetUnderTest(
        Builder(builder: (context) => detailsStyle.buildAddButton(
          context,
          isLoading: false,
          onAdd: () => addCalled = true,
        )),
      ));

      await tester.tap(find.byType(ElevatedButton));
      expect(addCalled, isTrue);
    });

    testWidgets('should render ProductQuantitySelector with specific details style dimensions', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest(
        Builder(builder: (context) => detailsStyle.buildQuantitySelector(
          context,
          quantity: 3,
          isLoading: false,
          isIncrementDisabled: false,
          isDecrementDisabled: false,
          onIncrement: () {},
          onDecrement: () {},
          onDelete: () {},
        )),
      ));

      final selectorFinder = find.byType(ProductQuantitySelector);
      expect(selectorFinder, findsOneWidget);

      // Verify dimensions passed to the selector
      final ProductQuantitySelector selector = tester.widget(selectorFinder);
      expect(selector.height, 54);
      expect(selector.iconSize, 22);
      expect(selector.quantity, 3);
    });

    testWidgets('should render disabled Out of Stock button with correct localization', (tester) async {
      late String expectedOutOfStockText;

      await tester.pumpWidget(createWidgetUnderTest(
        Builder(builder: (context) {
          expectedOutOfStockText = context.l10n.outOfStock;
          return detailsStyle.buildSoldOut(context);
        }),
      ));

      expect(find.text(expectedOutOfStockText), findsOneWidget);

      final ElevatedButton button = tester.widget(find.byType(ElevatedButton));
      expect(button.enabled, isFalse);

      // Verify height
      final SizedBox container = tester.widget(find.byType(SizedBox).first);
      expect(container.height, 54);
    });
  });
}