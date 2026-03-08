import 'package:flowers_app/Features/auth/presentation/forget_password/view_model/forget_password_cubit.dart';
import 'package:flowers_app/Features/auth/presentation/forget_password/view_model/forget_password_states.dart';
import 'package:flowers_app/Features/auth/presentation/forget_password/widgets/resend_code_view_body.dart';
import 'package:flowers_app/Features/auth/presentation/forget_password/widgets/send_code_screen.dart';
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

  setUp(() {
    mockCubit = MockForgetPasswordCubit();

    // Provide a default state to avoid null errors during build
    when(mockCubit.state).thenReturn(ForgetPasswordState());
    when(
      mockCubit.stream,
    ).thenAnswer((_) => Stream.value(ForgetPasswordState()));
  });

  Widget createWidgetUnderTest({
    required VoidCallback onPreviousPage,
    required VoidCallback onNextPage,
  }) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: BlocProvider<ForgetPasswordCubit>.value(
        value: mockCubit,
        child: SendCodeScreen(
          onPreviousPage: onPreviousPage,
          onNextPage: onNextPage,
        ),
      ),
    );
  }

  group('SendCodeScreen Unit Tests', () {
    testWidgets('should render AppBar with correct title and leading icon', (
        tester,
        ) async {
      await tester.pumpWidget(
        createWidgetUnderTest(onPreviousPage: () {}, onNextPage: () {}),
      );
      await tester.pumpAndSettle();

      // Verify AppBar exists
      expect(find.byType(AppBar), findsOneWidget);

      final BuildContext context = tester.element(find.byType(SendCodeScreen));
      final expectedTitle = AppLocalizations.of(context)!.passwordLabel;

      expect(find.text(expectedTitle), findsOneWidget);

      // Verify Back Icon exists
      expect(find.byIcon(Icons.arrow_back_ios), findsOneWidget);
    });
    testWidgets('should trigger onPreviousPage when back button is pressed', (
      tester,
    ) async {
      bool isBackCalled = false;

      await tester.pumpWidget(
        createWidgetUnderTest(
          onPreviousPage: () => isBackCalled = true,
          onNextPage: () {},
        ),
      );

      final backButton = find.byType(IconButton);
      await tester.tap(backButton);
      await tester.pump();

      expect(isBackCalled, isTrue);
    });

    testWidgets('should contain SendCodeScreenBody', (tester) async {
      await tester.pumpWidget(
        createWidgetUnderTest(onPreviousPage: () {}, onNextPage: () {}),
      );

      expect(find.byType(SendCodeScreenBody), findsOneWidget);
    });
  });
}
