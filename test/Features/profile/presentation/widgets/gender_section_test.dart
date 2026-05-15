 import 'package:flowers_app/Features/profile/presentation/widgets/gender_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('GenderRadioButton Widget Tests', () {
    testWidgets('should display label correctly', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: GenderRadioButton(
              label: 'Male',
              isSelected: false,
            ),
          ),
        ),
      );

      expect(find.text('Male'), findsOneWidget);
    });

    testWidgets('should show inner circle when isSelected is true', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: GenderRadioButton(
              label: 'Female',
              isSelected: true,
            ),
          ),
        ),
      );

      final innerCircleFinder = find.descendant(
        of: find.byType(GenderRadioButton),
        matching: find.byWidgetPredicate((widget) =>
        widget is Container &&
            widget.decoration is BoxDecoration &&
            (widget.decoration as BoxDecoration).shape == BoxShape.circle &&
            widget.child == null),
      );

      expect(innerCircleFinder, findsOneWidget);
    });

    testWidgets('should NOT show inner circle when isSelected is false', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: GenderRadioButton(
              label: 'Male',
              isSelected: false,
            ),
          ),
        ),
      );

      final centerFinder = find.descendant(
        of: find.byType(GenderRadioButton),
        matching: find.byType(Center),
      );

      expect(centerFinder, findsNothing);
    });

    testWidgets('should trigger onTap when clicked', (tester) async {
      bool tapped = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: SizedBox(
                width: 200,
                height: 50,
                child: GenderRadioButton(
                  label: 'Male',
                  isSelected: false,
                  onTap: () => tapped = true,
                ),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Male'), warnIfMissed: false);
      await tester.pump();

      expect(tapped, isTrue);
    });
  });
}