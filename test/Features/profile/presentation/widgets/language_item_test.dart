import 'package:flowers_app/Features/profile/presentation/widgets/language_item.dart'; // تأكدي من المسار
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LanguageItem Widget Tests', () {

    testWidgets('should display language name correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LanguageItem(
              language: 'English',
              isSelected: false,
              onTap: () {},
            ),
          ),
        ),
      );

      expect(find.text('English'), findsOneWidget);
    });

    testWidgets('should show radio_button_checked when isSelected is true', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LanguageItem(
              language: 'Arabic',
              isSelected: true,
              onTap: () {},
            ),
          ),
        ),
      );

       expect(find.byIcon(Icons.radio_button_checked), findsOneWidget);
      expect(find.byIcon(Icons.radio_button_off), findsNothing);
    });

    testWidgets('should show radio_button_off when isSelected is false', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LanguageItem(
              language: 'Arabic',
              isSelected: false,
              onTap: () {},
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.radio_button_off), findsOneWidget);
      expect(find.byIcon(Icons.radio_button_checked), findsNothing);
    });

    testWidgets('should trigger onTap callback when pressed', (tester) async {
      bool isPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LanguageItem(
              language: 'English',
              isSelected: false,
              onTap: () {
                isPressed = true;
              },
            ),
          ),
        ),
      );

       await tester.tap(find.byType(LanguageItem));
      await tester.pump();

      expect(isPressed, isTrue);
    });
  });
}