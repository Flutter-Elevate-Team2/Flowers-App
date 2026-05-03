import 'package:flowers_app/Features/commerce/presentation/products/widgets/shared/product_card/product_quantity_selector.dart';
import 'package:flowers_app/core/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget createWidgetUnderTest({
    required int quantity,
    bool isIncrementDisabled = false,
    bool isDecrementDisabled = false,
    bool isLoading = false,
    VoidCallback? onIncrement,
    VoidCallback? onDecrement,
    VoidCallback? onDelete,
  }) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: ProductQuantitySelector(
          quantity: quantity,
          isIncrementDisabled: isIncrementDisabled,
          isDecrementDisabled: isDecrementDisabled,
          isLoading: isLoading,
          onIncrement: onIncrement,
          onDecrement: onDecrement,
          onDelete: onDelete,
        ),
      ),
    );
  }

  group('ProductQuantitySelector Widget Tests', () {
    testWidgets('Initial State: renders correctly with quantity > 1', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest(quantity: 5));

      expect(find.text('5'), findsOneWidget);
      expect(find.byIcon(Icons.remove), findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget);
      expect(find.byIcon(Icons.delete_outline), findsNothing);
    });

    testWidgets('Initial State: renders delete icon when quantity is 1', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest(quantity: 1));

      expect(find.text('1'), findsOneWidget);
      expect(find.byIcon(Icons.delete_outline), findsOneWidget);
      expect(find.byIcon(Icons.remove), findsNothing);
    });

    testWidgets('Interaction: calls onIncrement when add button is pressed', (tester) async {
      bool incrementCalled = false;
      await tester.pumpWidget(createWidgetUnderTest(
        quantity: 2,
        onIncrement: () => incrementCalled = true,
      ));

      await tester.tap(find.byIcon(Icons.add));
      expect(incrementCalled, isTrue);
    });

    testWidgets('Interaction: calls onDecrement when remove button is pressed and quantity > 1', (tester) async {
      bool decrementCalled = false;
      await tester.pumpWidget(createWidgetUnderTest(
        quantity: 2,
        onDecrement: () => decrementCalled = true,
      ));

      await tester.tap(find.byIcon(Icons.remove));
      expect(decrementCalled, isTrue);
    });

    testWidgets('Interaction: calls onDelete when delete button is pressed and quantity is 1', (tester) async {
      bool deleteCalled = false;
      await tester.pumpWidget(createWidgetUnderTest(
        quantity: 1,
        onDelete: () => deleteCalled = true,
      ));

      await tester.tap(find.byIcon(Icons.delete_outline));
      expect(deleteCalled, isTrue);
    });

    testWidgets('Loading State: ignores pointer when isLoading is true', (tester) async {
      bool incrementCalled = false;
      await tester.pumpWidget(createWidgetUnderTest(
        quantity: 2,
        isLoading: true,
        onIncrement: () => incrementCalled = true,
      ));

      await tester.tap(find.byIcon(Icons.add), warnIfMissed: false);
      expect(incrementCalled, isFalse);
    });

    testWidgets('Disabled State: buttons are disabled based on flags', (tester) async {
      bool incrementCalled = false;
      bool decrementCalled = false;

      await tester.pumpWidget(createWidgetUnderTest(
        quantity: 2,
        isIncrementDisabled: true,
        isDecrementDisabled: true,
        onIncrement: () => incrementCalled = true,
        onDecrement: () => decrementCalled = true,
      ));

      await tester.tap(find.byIcon(Icons.add), warnIfMissed: false);
      await tester.tap(find.byIcon(Icons.remove), warnIfMissed: false);

      expect(incrementCalled, isFalse);
      expect(decrementCalled, isFalse);
    });
  });
}
