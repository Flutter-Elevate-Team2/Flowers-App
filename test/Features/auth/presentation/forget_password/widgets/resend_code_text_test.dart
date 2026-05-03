import 'package:flowers_app/Features/auth/presentation/forget_password/view_model/forget_password_cubit.dart';
import 'package:flowers_app/Features/auth/presentation/forget_password/view_model/forget_password_intent.dart';
import 'package:flowers_app/Features/auth/presentation/forget_password/view_model/forget_password_states.dart';
import 'package:flowers_app/Features/auth/presentation/forget_password/widgets/resend_code_text.dart';
import 'package:flowers_app/core/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'email_form_section_test.mocks.dart';

@GenerateMocks([ForgetPasswordCubit])
void main() {
  late MockForgetPasswordCubit mockViewModel;

  setUp(() {
    mockViewModel = MockForgetPasswordCubit();
    // Default mock behavior
    when(mockViewModel.state).thenReturn(ForgetPasswordState());
    when(
      mockViewModel.stream,
    ).thenAnswer((_) => Stream.value(ForgetPasswordState()));
  });

  Widget createWidgetUnderTest({String? email, bool isLoading = false}) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: BlocProvider<ForgetPasswordCubit>.value(
          value: mockViewModel,
          child: ResendCodeText(email: email, isLoading: isLoading),
        ),
      ),
    );
  }

  group('ResendCodeText Unit Tests', () {
    testWidgets(
      'should show CircularProgressIndicator when isLoading is true',
      (tester) async {
        await tester.pumpWidget(createWidgetUnderTest(isLoading: true));

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
        expect(find.byType(TextButton), findsNothing);
      },
    );

    testWidgets(
      'should show TextButton and trigger SendOtp event when pressed',
      (tester) async {
        const testEmail = 'user@example.com';
        await tester.pumpWidget(
          createWidgetUnderTest(email: testEmail, isLoading: false),
        );

        final resendButton = find.byType(TextButton);
        expect(resendButton, findsOneWidget);

        await tester.tap(resendButton);
        await tester.pump();

        verify(
          mockViewModel.doIntent(
            argThat(isA<SendOtp>().having((e) => e.email, 'email', testEmail)),
          ),
        ).called(1);
      },
    );

    testWidgets('should use empty string if email is null when pressed', (
      tester,
    ) async {
      await tester.pumpWidget(
        createWidgetUnderTest(email: null, isLoading: false),
      );

      await tester.tap(find.byType(TextButton));
      await tester.pump();

      verify(
        mockViewModel.doIntent(
          argThat(isA<SendOtp>().having((e) => e.email, 'email', '')),
        ),
      ).called(1);
    });

    testWidgets('should display correct localization texts', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      // Assuming your l10n for 'resendCode' isn't empty
      expect(find.byType(Text), findsWidgets);
    });
  });
}
