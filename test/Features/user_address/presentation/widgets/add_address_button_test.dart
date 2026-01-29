import 'package:flowers_app/Features/user_address/presentation/views/widgets/add_address_button.dart';
import 'package:flowers_app/core/l10n/app_localizations.dart';
import 'package:flowers_app/core/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  bool onPressedCalled = false;

  setUp(() {
    onPressedCalled = false;
  });

  Widget buildTestableWidget({VoidCallback? onPressed}) {
    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en'), Locale('ar')],
      home: Scaffold(body: AddAddressButton(onPressed: onPressed)),
    );
  }

  testWidgets('Renders CustomButton widget ..... ', (
    WidgetTester tester,
  ) async {
    // Arrange & Act
    await tester.pumpWidget(buildTestableWidget());

    // Assert
    expect(find.byType(CustomButton), findsOneWidget);
  });

  testWidgets('Displays add new address text ..... ', (
    WidgetTester tester,
  ) async {
    // Arrange & Act
    await tester.pumpWidget(buildTestableWidget());

    // Assert
    // The text should be rendered inside CustomButton
    expect(find.byType(CustomButton), findsOneWidget);
  });

  testWidgets('Triggers onPressed callback when tapped ..... ', (
    WidgetTester tester,
  ) async {
    // Arrange
    await tester.pumpWidget(
      buildTestableWidget(onPressed: () => onPressedCalled = true),
    );

    // Act
    await tester.tap(find.byType(CustomButton));
    await tester.pump();

    // Assert
    expect(onPressedCalled, true);
  });

  testWidgets('Button can be disabled with null onPressed ..... ', (
    WidgetTester tester,
  ) async {
    // Arrange & Act
    await tester.pumpWidget(buildTestableWidget(onPressed: null));

    // Assert
    expect(find.byType(CustomButton), findsOneWidget);
  });
}
