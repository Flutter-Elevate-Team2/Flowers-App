import 'package:flowers_app/Features/user_address/presentation/views/widgets/add_address_button.dart';
import 'package:flowers_app/core/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget createWidgetUnderTest({VoidCallback? onPressed}) {
    return MaterialApp(
      // ضروري جداً لتعريف المترجم داخل التست
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('en'), // نثبت اللغة على الإنجليزية للتأكد من النص
      home: Scaffold(
        body: AddAddressButton(onPressed: onPressed ?? () {}),
      ),
    );
  }

  testWidgets('should render AddAddressButton with correct localized text', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    // بدلاً من كتابة النص يدوياً "Add New Address"
    // نستخدم AppLocalizations لجلب النص الفعلي المكتوب في ملف الـ AR/EN
    final BuildContext context = tester.element(find.byType(AddAddressButton));
    final expectedText = AppLocalizations.of(context)!.addNewAddress;

    // الآن نبحث عن النص المترجم أياً كان
    expect(find.text(expectedText), findsOneWidget);
  });

  testWidgets('should trigger onPressed when tapped', (tester) async {
    bool isPressed = false;
    await tester.pumpWidget(createWidgetUnderTest(onPressed: () => isPressed = true));

    // نضغط على الزرار باستخدام الـ Type أو الـ Text المترجم
    await tester.tap(find.byType(AddAddressButton));
    await tester.pump();

    expect(isPressed, isTrue);
  });
}