import 'dart:async';
import 'package:flowers_app/Features/auth/presentation/forget_password/view_model/forget_password_cubit.dart';
import 'package:flowers_app/Features/auth/presentation/forget_password/view_model/forget_password_intent.dart';
import 'package:flowers_app/Features/auth/presentation/forget_password/view_model/forget_password_states.dart';
import 'package:flowers_app/Features/auth/domain/entities/verify_password_entity.dart';
import 'package:flowers_app/Features/auth/presentation/forget_password/widgets/otp_input_widget.dart';
import 'package:flowers_app/Features/auth/presentation/forget_password/widgets/resend_code_text.dart';
import 'package:flowers_app/Features/auth/presentation/forget_password/widgets/resend_code_view_body.dart';
import 'package:flowers_app/core/base_states/base_states.dart';
import 'package:flowers_app/core/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'email_form_section_test.mocks.dart';

@GenerateMocks([ForgetPasswordCubit])
void main() {
  late MockForgetPasswordCubit mockCubit;
  late StreamController<ForgetPasswordState> stateController;

  setUp(() {
    mockCubit = MockForgetPasswordCubit();
    stateController = StreamController<ForgetPasswordState>.broadcast();

    // Default state
    when(mockCubit.state).thenReturn(ForgetPasswordState());
    when(mockCubit.stream).thenAnswer((_) => stateController.stream);
  });

  tearDown(() {
    stateController.close();
  });

  Widget createWidgetUnderTest({required VoidCallback onNextPage}) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: BlocProvider<ForgetPasswordCubit>.value(
          value: mockCubit,
          child: SendCodeScreenBody(onNextPage: onNextPage),
        ),
      ),
    );
  }

  group('SendCodeScreenBody Unit Tests', () {
    testWidgets('should display title, subtitle, and OtpInputWidget', (
      tester,
    ) async {
      await tester.pumpWidget(createWidgetUnderTest(onNextPage: () {}));
      await tester.pumpAndSettle();

      expect(find.byType(OtpInputWidget), findsOneWidget);
      expect(find.textContaining(''), findsWidgets); // Title/Subtitle from l10n
    });

    testWidgets(
      'should show CircularProgressIndicator when verifyOtpState is loading',
      (tester) async {
        final loadingState = ForgetPasswordState(
          verifyOtpState: const BaseState(isLoading: true),
        );

        when(mockCubit.state).thenReturn(loadingState);
        stateController.add(loadingState);

        await tester.pumpWidget(createWidgetUnderTest(onNextPage: () {}));
        await tester.pump();

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
        expect(find.byType(ResendCodeText), findsNothing);
      },
    );

    testWidgets('should trigger VerifyOtp intent when OTP is completed', (
      tester,
    ) async {
      await tester.pumpWidget(createWidgetUnderTest(onNextPage: () {}));

      // Simulate OTP completion
      final otpWidget = tester.widget<OtpInputWidget>(
        find.byType(OtpInputWidget),
      );
      otpWidget.onCompleted.call('123456');

      verify(
        mockCubit.doIntent(
          argThat(isA<VerifyOtp>().having((i) => i.otp, 'otp', '123456')),
        ),
      ).called(1);
    });

    testWidgets('should call onNextPage when verifyOtpState has data', (
      tester,
    ) async {
      bool isNavigated = false;
      await tester.pumpWidget(
        createWidgetUnderTest(onNextPage: () => isNavigated = true),
      );

      // Emit Success State
      final successState = ForgetPasswordState(
        verifyOtpState: BaseState(
          isLoading: false,
          data: VerifyPasswordEntity(status: 'success'),
        ),
      );

      stateController.add(successState);
      await tester.pumpAndSettle();

      expect(isNavigated, isTrue);
    });

    testWidgets('should display error message from state in OtpInputWidget', (
      tester,
    ) async {
      const errorMsg = 'Invalid OTP Code';
      final errorState = ForgetPasswordState(
        verifyOtpState: const BaseState(
          isLoading: false,
          errorMessage: errorMsg,
        ),
      );

      when(mockCubit.state).thenReturn(errorState);

      await tester.pumpWidget(createWidgetUnderTest(onNextPage: () {}));
      await tester.pump();

      expect(find.text(errorMsg), findsOneWidget);
    });
  });
}
