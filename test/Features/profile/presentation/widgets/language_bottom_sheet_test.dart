import 'package:bloc_test/bloc_test.dart';
import 'package:flowers_app/Features/profile/presentation/widgets/language_bottom_sheet.dart';
import 'package:flowers_app/Features/profile/presentation/widgets/language_item.dart';
import 'package:flowers_app/core/l10n/view_model/language_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flowers_app/core/l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MockLanguageCubit extends MockCubit<Locale> implements LanguageCubit {}

void main() {
  late MockLanguageCubit mockLanguageCubit;

  setUp(() {
    mockLanguageCubit = MockLanguageCubit();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en'), Locale('ar')],
      home: Scaffold(
        body: LanguageBottomSheet(viewModel: mockLanguageCubit),
      ),
    );
  }

  group('LanguageBottomSheet Widget Tests', () {
    testWidgets('should show Arabic as selected when current locale is ar', (tester) async {
      when(() => mockLanguageCubit.state).thenReturn(const Locale('ar'));

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

     final arabicItem = find.ancestor(
        of: find.text('Arabic'),
        matching: find.byType(LanguageItem),
      );

      expect(
        find.descendant(of: arabicItem, matching: find.byIcon(Icons.radio_button_checked)),
        findsOneWidget,
      );
    });

    testWidgets('should call changeLanguage when a language item is tapped', (tester) async {
      when(() => mockLanguageCubit.state).thenReturn(const Locale('en'));

       when(() => mockLanguageCubit.changeLanguage(any())).thenAnswer((_) async {});

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      await tester.tap(find.text('Arabic'));
      await tester.pump();

      verify(() => mockLanguageCubit.changeLanguage('ar')).called(1);
    });
    testWidgets('should render both Arabic and English options', (tester) async {
      when(() => mockLanguageCubit.state).thenReturn(const Locale('en'));

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(LanguageItem), findsNWidgets(2));
      expect(find.text('English'), findsOneWidget);
      expect(find.text('Arabic'), findsOneWidget);
    });
  });
}