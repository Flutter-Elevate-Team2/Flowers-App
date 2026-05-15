import 'package:bloc_test/bloc_test.dart';
import 'package:flowers_app/Features/auth/domain/entities/reset_password_entity.dart';
import 'package:flowers_app/Features/auth/presentation/forget_password/view_model/forget_password_cubit.dart';
import 'package:flowers_app/Features/auth/presentation/forget_password/view_model/forget_password_states.dart';
import 'package:flowers_app/Features/auth/presentation/forget_password/widgets/new_password_form.dart';
import 'package:flowers_app/core/base_states/base_states.dart';
import 'package:flowers_app/core/l10n/app_localizations.dart';
import 'package:flowers_app/core/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockForgetPasswordCubit extends MockCubit<ForgetPasswordState>
    implements ForgetPasswordCubit {}

void main() {
  late MockForgetPasswordCubit mockCubit;

  setUp(() {
    mockCubit = MockForgetPasswordCubit();
  });

  Widget createWidgetUnderTest(Widget child) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: BlocProvider<ForgetPasswordCubit>.value(
          value: mockCubit,
          child: child,
        ),
      ),
    );
  }

  group('NewPasswordForm Tests', () {
    testWidgets('Toggle Password Visibility works', (tester) async {
      when(() => mockCubit.state).thenReturn(ForgetPasswordState());

      await tester.pumpWidget(
        createWidgetUnderTest(
          const NewPasswordForm(userEmail: 'test@mail.com'),
        ),
      );

      // Fix: Find the TextField instead of TextFormField to check obscureText
      final passwordField = find.byType(TextField).first;

      // Check initial state (obscured)
      expect(tester.widget<TextField>(passwordField).obscureText, isTrue);

      // Tap eye icon
      await tester.tap(find.byIcon(Icons.visibility_off).first);
      await tester.pump();

      // Check state (visible)
      expect(tester.widget<TextField>(passwordField).obscureText, isFalse);
    });

    testWidgets('Shows Success Dialog on successful reset', (tester) async {
      whenListen(
        mockCubit,
        Stream.fromIterable([
          ForgetPasswordState(),
          ForgetPasswordState(
            resetPasswordState: BaseState(
              isLoading: false,
              data: ResetPasswordEntity(message: 'Done', token: 'token'),
            ),
          ),
        ]),
        initialState: ForgetPasswordState(),
      );

      await tester.pumpWidget(
        createWidgetUnderTest(
          const NewPasswordForm(userEmail: 'test@mail.com'),
        ),
      );

      await tester.pump();

      expect(find.byType(AlertDialog), findsOneWidget);
    });
  });
}
