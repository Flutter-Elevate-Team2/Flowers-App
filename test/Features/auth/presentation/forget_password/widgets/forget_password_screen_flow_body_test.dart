import 'package:flowers_app/Features/auth/presentation/forget_password/view_model/forget_password_cubit.dart';
import 'package:flowers_app/Features/auth/presentation/forget_password/view_model/forget_password_states.dart';
import 'package:flowers_app/Features/auth/presentation/forget_password/widgets/forget_password_pageview.dart';
import 'package:flowers_app/Features/auth/presentation/forget_password/widgets/forget_password_screen_flow_body.dart';
import 'package:flowers_app/core/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/mockito.dart';

import 'email_form_section_test.mocks.dart';


void main() {
  late MockForgetPasswordCubit mockViewModel;

  setUp(() {
    mockViewModel = MockForgetPasswordCubit();

    when(mockViewModel.state).thenReturn(ForgetPasswordState());
    when(
      mockViewModel.stream,
    ).thenAnswer((_) => Stream.value(ForgetPasswordState()));
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: BlocProvider<ForgetPasswordCubit>.value(
        value: mockViewModel,
        child: const Scaffold(body: ForgetPasswordScreenFlowBody()),
      ),
    );
  }

  group('ForgetPasswordScreenFlowBody Tests with Mockito', () {
    testWidgets('1. Should update userEmail and navigate correctly', (
        tester,
        ) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      final pageViewFinder = find.byType(ForgetPasswordPageview);
      final pageViewWidget = tester.widget<ForgetPasswordPageview>(
        pageViewFinder,
      );

      pageViewWidget.onEmailSubmitted?.call('test@example.com');
      await tester.pump();

      final updatedPageView = tester.widget<ForgetPasswordPageview>(
        find.byType(ForgetPasswordPageview),
      );
      expect(updatedPageView.userEmail, 'test@example.com');

      final PageView internalPageView = tester.widget(find.byType(PageView));
      final controller = internalPageView.controller!;

      pageViewWidget.onNextPage();
      await tester.pumpAndSettle();

      expect(controller.page?.round(), 1);
    });

    testWidgets('2. Should respect boundary navigation', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      final pageViewWidget = tester.widget<ForgetPasswordPageview>(
        find.byType(ForgetPasswordPageview),
      );
      final PageView internalPageView = tester.widget(find.byType(PageView));
      final controller = internalPageView.controller!;

      pageViewWidget.onPreviousPage();
      await tester.pumpAndSettle();
      expect(controller.page?.round(), 0);

      pageViewWidget.onNextPage(); // page 1
      await tester.pumpAndSettle();
      pageViewWidget.onNextPage(); // page 2
      await tester.pumpAndSettle();
      expect(controller.page?.round(), 2);
    });

    testWidgets('3. Should navigate backward from middle page', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      final pageViewWidget = tester.widget<ForgetPasswordPageview>(
        find.byType(ForgetPasswordPageview),
      );
      final PageView internalPageView = tester.widget(find.byType(PageView));
      final controller = internalPageView.controller!;

      pageViewWidget.onNextPage();
      await tester.pumpAndSettle();

      pageViewWidget.onPreviousPage();
      await tester.pumpAndSettle();

      expect(controller.page?.round(), 0);
    });

    testWidgets('4. Should not navigate beyond the last page', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      final pageViewWidget = tester.widget<ForgetPasswordPageview>(
        find.byType(ForgetPasswordPageview),
      );
      final PageView internalPageView = tester.widget(find.byType(PageView));
      final controller = internalPageView.controller!;

      pageViewWidget.onNextPage(); // page 1
      await tester.pumpAndSettle();
      pageViewWidget.onNextPage(); // page 2
      await tester.pumpAndSettle();

      pageViewWidget.onNextPage();
      await tester.pumpAndSettle();

      expect(controller.page?.round(), 2);
    });
  });
}
