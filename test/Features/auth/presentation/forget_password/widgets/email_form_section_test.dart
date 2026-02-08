import 'package:bloc_test/bloc_test.dart';
import 'package:flowers_app/Features/auth/domain/entities/forget_password_entity.dart';
import 'package:flowers_app/Features/auth/presentation/forget_password/view_model/forget_password_cubit.dart';
import 'package:flowers_app/Features/auth/presentation/forget_password/view_model/forget_password_states.dart';
import 'package:flowers_app/Features/auth/presentation/forget_password/view_model/forget_password_intent.dart';
import 'package:flowers_app/Features/auth/presentation/forget_password/widgets/email_form_section.dart';
import 'package:flowers_app/core/base_states/base_states.dart';
import 'package:flowers_app/core/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockForgetPasswordCubit extends MockCubit<ForgetPasswordState>
    implements ForgetPasswordCubit {}

void main() {
  late MockForgetPasswordCubit mockCubit;

  setUpAll(() {
    registerFallbackValue(SendOtp(email: 'dummy_email'));
  });

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

  group('EmailFormSection Tests', () {
    testWidgets('Validates empty email', (tester) async {
      when(() => mockCubit.state).thenReturn(ForgetPasswordState());

      await tester.pumpWidget(createWidgetUnderTest(
        EmailFormSection(onNextPage: () {}),
      ));

      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      expect(find.textContaining('Email is required'), findsOneWidget);

      verifyNever(() => mockCubit.doIntent(any()));
    });

    testWidgets('Shows Loading Indicator when isLoading is true', (tester) async {
      when(() => mockCubit.state).thenReturn(
        ForgetPasswordState(sendOtpState: BaseState(isLoading: true)),
      );

      await tester.pumpWidget(createWidgetUnderTest(
        EmailFormSection(onNextPage: () {}),
      ));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Confirm'), findsNothing);
    });

    testWidgets('Calls onNextPage when success state is emitted', (tester) async {
      bool nextPageCalled = false;

      whenListen(
        mockCubit,
        Stream.fromIterable([
          ForgetPasswordState(),
          ForgetPasswordState(
              sendOtpState: BaseState(
                  isLoading: false,
                  data: ForgetPasswordEntity(message: 'Success', info: 'info')
              )
          ),
        ]),
        initialState: ForgetPasswordState(),
      );

      await tester.pumpWidget(createWidgetUnderTest(
        EmailFormSection(onNextPage: () {
          nextPageCalled = true;
        }),
      ));

      await tester.pump();

      expect(nextPageCalled, isTrue);
    });
  });
}
