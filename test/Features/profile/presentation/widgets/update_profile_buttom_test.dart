 import 'package:flowers_app/Features/profile/presentation/widgets/update_profile_buttom.dart';
import 'package:flowers_app/core/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget createWidgetUnderTest({VoidCallback? onPressed}) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('en'),
      home: Scaffold(
        body: UpdateProfileButton(onPressed: onPressed),
      ),
    );
  }

  testWidgets('Should display correct translated text from l10n', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    // نستخدم الـ context عشان نجيب النص المترجم فعلياً
    final BuildContext context = tester.element(find.byType(UpdateProfileButton));
    final String expectedText = AppLocalizations.of(context)!.update;

    expect(find.text(expectedText), findsOneWidget);
  });

  testWidgets('Should call onPressed when tapped and enabled', (tester) async {
    bool isPressed = false;

    await tester.pumpWidget(createWidgetUnderTest(
      onPressed: () => isPressed = true,
    ));

    // نضغط على الزرار
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    expect(isPressed, isTrue);
  });

  testWidgets('Should be disabled when onPressed is null', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest(onPressed: null));

    final ElevatedButton button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));

    // في Flutter، الزرار بيكون Disabled لو الـ onPressed بـ null
    expect(button.enabled, isFalse);
  });

  testWidgets('Should have full width (infinity) decoration', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    final SizedBox sizedBox = tester.widget<SizedBox>(find.byType(SizedBox));

    expect(sizedBox.width, double.infinity);
    expect(sizedBox.height, 50);
  });
}