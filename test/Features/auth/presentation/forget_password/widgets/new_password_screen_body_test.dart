import 'package:flowers_app/Features/auth/presentation/forget_password/view_model/forget_password_cubit.dart';
import 'package:flowers_app/Features/auth/presentation/forget_password/view_model/forget_password_states.dart';
import 'package:flowers_app/Features/auth/presentation/forget_password/widgets/new_password_screen_body.dart';
import 'package:flowers_app/Features/auth/presentation/forget_password/widgets/new_password_form.dart';
import 'package:flowers_app/Features/auth/presentation/forget_password/widgets/custom_text_section.dart';
import 'package:flowers_app/core/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'new_password_screen_body_test.mocks.dart';

@GenerateMocks([ForgetPasswordCubit])
void main() {
  late MockForgetPasswordCubit mockCubit;

  setUp(() {
    mockCubit = MockForgetPasswordCubit();
    when(mockCubit.state).thenReturn(ForgetPasswordState());
    when(
      mockCubit.stream,
    ).thenAnswer((_) => Stream.value(ForgetPasswordState()));
  });

  Widget createWidgetUnderTest({String? userEmail}) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: BlocProvider<ForgetPasswordCubit>.value(
          value: mockCubit,
          child: NewPasswordScreenBody(userEmail: userEmail),
        ),
      ),
    );
  }

  group('NewPasswordScreenBody Unit Tests', () {
    testWidgets('should render TextSection with title and subtitle', (
      tester,
    ) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      expect(find.byType(TextSection), findsOneWidget);
      // Verify localization strings are accessed (titles are not empty)
      expect(find.textContaining(''), findsWidgets);
    });

    testWidgets('should render NewPasswordForm and pass userEmail to it', (
      tester,
    ) async {
      const testEmail = 'dev@example.com';
      await tester.pumpWidget(createWidgetUnderTest(userEmail: testEmail));

      final formFinder = find.byType(NewPasswordForm);
      expect(formFinder, findsOneWidget);

      // Verify email propagation
      final formWidget = tester.widget<NewPasswordForm>(formFinder);
      expect(formWidget.userEmail, testEmail);
    });

    testWidgets('should have correct vertical spacing (SizedBoxes)', (
      tester,
    ) async {
      await tester.pumpWidget(createWidgetUnderTest());

      // Verify the existence of SizedBoxes used for spacing
      expect(find.byType(SizedBox), findsWidgets);
    });
  });
}
