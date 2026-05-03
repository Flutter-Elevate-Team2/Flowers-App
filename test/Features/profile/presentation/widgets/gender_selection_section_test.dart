import 'package:flowers_app/Features/profile/presentation/widgets/gender_section.dart';
import 'package:flowers_app/Features/profile/presentation/widgets/gender_selection_section.dart';
 import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flowers_app/core/l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  Widget createWidgetUnderTest(String gender) {
    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en'), Locale('ar')],
      home: Scaffold(
        body: GenderSelectionSection(selectedGender: gender),
      ),
    );
  }

  group('GenderSelectionSection Widget Tests', () {
    testWidgets('should select Female radio button when selectedGender is female', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest('female'));
      await tester.pumpAndSettle();

      final femaleRadio = tester.widget<GenderRadioButton>(
        find.widgetWithText(GenderRadioButton, 'Female'),
      );
      final maleRadio = tester.widget<GenderRadioButton>(
        find.widgetWithText(GenderRadioButton, 'Male'),
      );

      expect(femaleRadio.isSelected, isTrue);
      expect(maleRadio.isSelected, isFalse);
    });

    testWidgets('should select Male radio button when selectedGender is male', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest('male'));
      await tester.pumpAndSettle();

      final femaleRadio = tester.widget<GenderRadioButton>(
        find.widgetWithText(GenderRadioButton, 'Female'),
      );
      final maleRadio = tester.widget<GenderRadioButton>(
        find.widgetWithText(GenderRadioButton, 'Male'),
      );

      expect(femaleRadio.isSelected, isFalse);
      expect(maleRadio.isSelected, isTrue);
    });

    testWidgets('should render gender label from l10n', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest('female'));
      await tester.pumpAndSettle();

      expect(find.text('Gender'), findsOneWidget);
    });
  });
}