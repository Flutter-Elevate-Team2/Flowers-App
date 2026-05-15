import 'dart:convert';
import 'package:flowers_app/Features/profile/presentation/views/terms_conditions_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flowers_app/core/l10n/app_localizations.dart';

@GenerateMocks([AssetBundle])
import 'terms_conditions_screen_test.mocks.dart';

void main() {
  late MockAssetBundle mockAssetBundle;

  setUp(() {
    mockAssetBundle = MockAssetBundle();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('en'),
      home: DefaultAssetBundle(
        bundle: mockAssetBundle,
        child: const TermsConditionsScreen(),
      ),
    );
  }

  testWidgets('Should show loading indicator when fetching JSON', (tester) async {
    when(mockAssetBundle.loadString(any)).thenAnswer(
          (_) => Future.delayed(const Duration(seconds: 1), () => '{}'),
    );

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Clean up the delayed future
    await tester.pump(const Duration(seconds: 1));
  });


 }