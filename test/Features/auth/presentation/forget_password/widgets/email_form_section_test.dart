import 'dart:async';

import 'package:flowers_app/Features/auth/domain/entities/forget_password_entity.dart';
import 'package:flowers_app/Features/auth/presentation/forget_password/view_model/forget_password_cubit.dart';
import 'package:flowers_app/Features/auth/presentation/forget_password/view_model/forget_password_states.dart';
import 'package:flowers_app/Features/auth/presentation/forget_password/widgets/email_form_section.dart';
import 'package:flowers_app/core/base_states/base_states.dart';
import 'package:flowers_app/core/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'email_form_section_test.mocks.dart';

@GenerateMocks([ForgetPasswordCubit])
void main() {
  late MockForgetPasswordCubit mockViewModel;
  late StreamController<ForgetPasswordState> stateController;

  setUp(() {
    mockViewModel = MockForgetPasswordCubit();
    stateController = StreamController<ForgetPasswordState>.broadcast();

    final initialState = ForgetPasswordState();

    when(mockViewModel.state).thenReturn(initialState);
    when(mockViewModel.stream).thenAnswer((_) => stateController.stream);
  });

  tearDown(() {
    stateController.close();
  });

  Widget createWidgetUnderTest(Widget child) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: BlocProvider<ForgetPasswordCubit>.value(
          value: mockViewModel,
          child: child,
        ),
      ),
    );
  }

  group('EmailFormSection Widget Tests', () {
    testWidgets('1. Should show validation error when email is empty', (
        tester,
        ) async {
      await tester.pumpWidget(
        createWidgetUnderTest(EmailFormSection(onNextPage: () {})),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      expect(find.textContaining('email'), findsOneWidget);
      verifyNever(mockViewModel.doIntent(any));
    });

    testWidgets('3. Should show SnackBar when error occurs', (tester) async {
      await tester.pumpWidget(
        createWidgetUnderTest(EmailFormSection(onNextPage: () {})),
      );

      stateController.add(
        ForgetPasswordState(
          sendOtpState: BaseState(
            isLoading: false,
            errorMessage: 'Server Error',
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 750));

      expect(find.text('Server Error'), findsOneWidget);
    });

    testWidgets('4. Should call onNextPage when success occurs', (
        tester,
        ) async {
      bool nextCalled = false;
      await tester.pumpWidget(
        createWidgetUnderTest(
          EmailFormSection(onNextPage: () => nextCalled = true),
        ),
      );

      stateController.add(
        ForgetPasswordState(
          sendOtpState: BaseState(
            isLoading: false,
            data: ForgetPasswordEntity(message: 'ok', info: ''),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(nextCalled, isTrue);
    });

  });
}
