import 'package:bloc_test/bloc_test.dart';
import 'package:flowers_app/Features/auth/presentation/sign_in/view_model/login_state.dart';
import 'package:flowers_app/Features/auth/presentation/sign_in/view_model/login_view_model.dart';
import 'package:flowers_app/Features/auth/presentation/sign_in/views/login_screen.dart';
import 'package:flowers_app/core/base_states/base_states.dart';
import 'package:flowers_app/core/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

class MockLoginViewModel extends MockCubit<LoginState>
    implements LoginViewModel {}

void main() {
  late MockLoginViewModel mockViewModel;

  setUp(() {
    mockViewModel = MockLoginViewModel();
    GetIt.I.registerSingleton<LoginViewModel>(mockViewModel);
  });

  tearDown(() {
    GetIt.I.unregister<LoginViewModel>();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: LoginScreen(),
    );
  }

  testWidgets('LoginScreen renders correctly', (WidgetTester tester) async {
    // Arrange
    whenListen(
      mockViewModel,
      Stream.value(LoginState()),
      initialState: LoginState(),
    );

    // Act
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    // Assert
    expect(find.byType(LoginScreen), findsOneWidget);
    // Add logic to find Email/Password fields if possible (depends on body implementation)
    // Assuming standard text fields are present
    expect(
      find.byType(TextFormField),
      findsAtLeastNWidgets(2),
    ); // Email & Password
  });

  testWidgets('show error snackbar on login error', (
    WidgetTester tester,
  ) async {
    // Arrange
    whenListen(
      mockViewModel,
      Stream.fromIterable([
        LoginState(loginState: BaseState(isLoading: true)),
        LoginState(
          loginState: BaseState(isLoading: false, errorMessage: 'Login Failed'),
        ),
      ]),
      initialState: LoginState(),
    );

    // Act
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump(); // Initial
    await tester.pump(); // Error Emit

    // Assert
    expect(find.text('Login Failed'), findsOneWidget);
  });
}
