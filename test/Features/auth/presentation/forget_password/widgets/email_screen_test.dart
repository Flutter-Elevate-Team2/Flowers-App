import 'dart:async';
import 'package:flowers_app/Features/auth/domain/entities/forget_password_entity.dart';
import 'package:flowers_app/Features/auth/presentation/forget_password/view_model/forget_password_cubit.dart';
import 'package:flowers_app/Features/auth/presentation/forget_password/view_model/forget_password_states.dart';
import 'package:flowers_app/Features/auth/presentation/forget_password/widgets/custom_text_section.dart';
import 'package:flowers_app/Features/auth/presentation/forget_password/widgets/email_form_section.dart';
import 'package:flowers_app/Features/auth/presentation/forget_password/widgets/email_screen_body.dart';
import 'package:flowers_app/core/base_states/base_states.dart';
import 'package:flowers_app/core/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'email_form_section_test.mocks.dart';

void main() {
  late MockForgetPasswordCubit mockViewModel;
  late StreamController<ForgetPasswordState> stateController;

  setUp(() {
    mockViewModel = MockForgetPasswordCubit();
    stateController = StreamController<ForgetPasswordState>.broadcast();

    when(mockViewModel.state).thenReturn(ForgetPasswordState());
    when(mockViewModel.stream).thenAnswer((_) => stateController.stream);
  });

  tearDown(() {
    stateController.close();
  });

  Widget createWidgetUnderTest({
    required VoidCallback onNextPage,
    Function(String)? onEmailSubmitted,
  }) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: BlocProvider<ForgetPasswordCubit>.value(
          value: mockViewModel,
          child: EmailScreenBody(
            onNextPage: onNextPage,
            onEmailSubmitted: onEmailSubmitted,
          ),
        ),
      ),
    );
  }

  group('ForgetPasswordEmailScreenBody Tests', () {
    testWidgets('1. Should render all static components correctly', (
        tester,
        ) async {
      await tester.pumpWidget(createWidgetUnderTest(onNextPage: () {}));
      await tester.pumpAndSettle();

      expect(find.byType(TextSection), findsOneWidget);

      expect(find.byType(EmailFormSection), findsOneWidget);

      expect(find.byType(Text), findsWidgets);
    });

    testWidgets('2. Should pass callbacks correctly to EmailFormSection', (
        tester,
        ) async {
      String? submittedEmail;
      bool nextCalled = false;

      await tester.pumpWidget(
        createWidgetUnderTest(
          onNextPage: () => nextCalled = true,
          onEmailSubmitted: (email) => submittedEmail = email,
        ),
      );

      await tester.pumpAndSettle();

      // enter email
      await tester.enterText(find.byType(TextFormField), 'test@example.com');

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // verify email callback
      expect(submittedEmail, 'test@example.com');

      // simulate success state from Bloc
      stateController.add(
        ForgetPasswordState(
          sendOtpState: BaseState(
            data: ForgetPasswordEntity(message: 'ok', info: ''),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // verify next page called
      expect(nextCalled, true);
    });

    testWidgets('3. Should verify layout constraints (Padding)', (
        tester,
        ) async {
      await tester.pumpWidget(createWidgetUnderTest(onNextPage: () {}));

      final paddingFinder = find.byType(Padding).first;
      final Padding paddingWidget = tester.widget(paddingFinder);

      expect(paddingWidget.padding, const EdgeInsets.symmetric(horizontal: 16));
    });
  });
}
