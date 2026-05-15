import 'package:flowers_app/Features/profile/presentation/widgets/edit_profile_app_bar.dart';
import 'package:flowers_app/core/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mockito/annotations.dart';

 @GenerateMocks([GoRouter])

void main() {
  Widget createWidgetUnderTest() {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('en'),
      home: const Scaffold(
        appBar: EditProfileAppBar(),
      ),
    );
  }

  testWidgets('Should display correct title and notification badge count', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

     final BuildContext context = tester.element(find.byType(EditProfileAppBar));
    final String expectedTitle = AppLocalizations.of(context)!.editProfile;

     expect(find.text(expectedTitle), findsOneWidget);

     expect(find.text('3'), findsOneWidget);

     expect(find.byIcon(Icons.notifications_none_outlined), findsOneWidget);
  });
  testWidgets('Should show back icon', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    // الـ Leading icon
    expect(find.byIcon(Icons.arrow_back_ios), findsOneWidget);
  });
}