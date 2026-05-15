import 'package:bloc_test/bloc_test.dart'; // استيراد مكتبة bloc_test
import 'package:flowers_app/Features/auth/presentation/forget_password/view_model/forget_password_cubit.dart';
import 'package:flowers_app/Features/auth/presentation/forget_password/view_model/forget_password_states.dart';
import 'package:flowers_app/Features/auth/presentation/forget_password/widgets/new_password_screen.dart';
import 'package:flowers_app/Features/auth/presentation/forget_password/widgets/new_password_screen_body.dart';
import 'package:flowers_app/core/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MockForgetPasswordCubit extends MockCubit<ForgetPasswordState>
    implements ForgetPasswordCubit {}

void main() {
  late MockForgetPasswordCubit mockCubit;

  setUp(() {
    mockCubit = MockForgetPasswordCubit();

    whenListen(
      mockCubit,
      Stream.fromIterable([ForgetPasswordState()]),
      initialState: ForgetPasswordState(),
    );
  });

  Widget createWidgetUnderTest({
    required VoidCallback onPreviousPage,
    String? userEmail,
  }) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: BlocProvider<ForgetPasswordCubit>.value(
        value: mockCubit,
        child: NewPasswordScreen(
          onPreviousPage: onPreviousPage,
          userEmail: userEmail,
        ),
      ),
    );
  }

  group('NewPasswordScreen Unit Tests', () {
    testWidgets('should render AppBar with back button and correct title', (
      tester,
    ) async {
      await tester.pumpWidget(createWidgetUnderTest(onPreviousPage: () {}));
      await tester.pumpAndSettle();

      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byIcon(Icons.arrow_back_ios), findsOneWidget);

      final BuildContext context = tester.element(
        find.byType(NewPasswordScreen),
      );
      final expectedTitle = AppLocalizations.of(context)!.passwordLabel;
      expect(find.text(expectedTitle), findsOneWidget);
    });

    testWidgets(
      'should trigger onPreviousPage when the back button is pressed',
          (tester) async {
        bool isBackTriggered = false;

        await tester.pumpWidget(
          createWidgetUnderTest(onPreviousPage: () => isBackTriggered = true),
        );

        final backButton = find.ancestor(
          of: find.byIcon(Icons.arrow_back_ios),
          matching: find.byType(IconButton),
        );

        await tester.tap(backButton);
        await tester.pump();

        expect(isBackTriggered, isTrue);
      },
    );

    testWidgets('should display NewPasswordScreenBody and pass userEmail', (
      tester,
    ) async {
      const testEmail = 'test@example.com';

      await tester.pumpWidget(
        createWidgetUnderTest(onPreviousPage: () {}, userEmail: testEmail),
      );

      final bodyFinder = find.byType(NewPasswordScreenBody);
      expect(bodyFinder, findsOneWidget);

      final bodyWidget = tester.widget<NewPasswordScreenBody>(bodyFinder);
      expect(bodyWidget.userEmail, testEmail);
    });
  });
}
