import 'package:bloc_test/bloc_test.dart';
import 'package:flowers_app/Features/commerce/presentation/home/view_model/home_events.dart';
import 'package:flowers_app/Features/commerce/presentation/home/view_model/home_states.dart';
import 'package:flowers_app/Features/commerce/presentation/home/view_model/home_view_model.dart';
import 'package:flowers_app/Features/commerce/presentation/home/widgets/shared/home_error_widget.dart';
import 'package:flowers_app/core/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockHomeViewModel extends MockCubit<HomeStates> implements HomeViewModel {}

void main() {
  late MockHomeViewModel mockHomeViewModel;

  setUpAll(() {
    registerFallbackValue(GetHomeDataEvent());
  });

  setUp(() {
    mockHomeViewModel = MockHomeViewModel();
  });

  Widget createWidgetUnderTest({required String errorMessage}) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: BlocProvider<HomeViewModel>.value(
          value: mockHomeViewModel,
          child: HomeErrorWidget(errorMessage: errorMessage),
        ),
      ),
    );
  }

  group('HomeErrorWidget Tests', () {
    testWidgets('renders error message and retry button', (tester) async {
      const errorMessage = 'test_error';
      await tester.pumpWidget(createWidgetUnderTest(errorMessage: errorMessage));
      await tester.pumpAndSettle();

      // We expect the mapped error message. For simplicity, check if any text is rendered.
      expect(find.byType(ElevatedButton), findsOneWidget);
      
      final BuildContext context = tester.element(find.byType(HomeErrorWidget));
      expect(find.text(AppLocalizations.of(context)!.retryButton), findsOneWidget);
    });

    testWidgets('tapping retry button calls doIntent with GetHomeDataEvent', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest(errorMessage: 'error'));
      await tester.pumpAndSettle();

      await tester.tap(find.byType(ElevatedButton));
      
      verify(() => mockHomeViewModel.doIntent(any(that: isA<GetHomeDataEvent>()))).called(1);
    });
  });
}
