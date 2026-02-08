import 'package:bloc_test/bloc_test.dart';
import 'package:flowers_app/Features/auth/presentation/sign_up/view_model/sign_up_states.dart';
import 'package:flowers_app/Features/auth/presentation/sign_up/view_model/sign_up_view_model.dart';
import 'package:flowers_app/Features/auth/presentation/sign_up/views/sign_up_screen.dart';
import 'package:flowers_app/core/base_states/base_states.dart';
import 'package:flowers_app/core/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

class MockSignUpViewModel extends MockCubit<SignUpStates>
    implements SignUpViewModel {}

void main() {
  late MockSignUpViewModel mockViewModel;

  setUp(() {
    mockViewModel = MockSignUpViewModel();
    GetIt.I.registerSingleton<SignUpViewModel>(mockViewModel);
  });

  tearDown(() {
    GetIt.I.unregister<SignUpViewModel>();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: SignUpScreen(),
    );
  }

  testWidgets('SignUpScreen renders correctly', (WidgetTester tester) async {
    // Arrange
    whenListen(
      mockViewModel,
      Stream.value(SignUpStates()),
      initialState: SignUpStates(),
    );

    // Act
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    // Assert
    expect(find.byType(SignUpScreen), findsOneWidget);
    // SignUp usually has Name, Email, Phone, Password, Confirm (approx 5+ fields)
    expect(find.byType(TextFormField), findsWidgets);
  });

  testWidgets('show error snackbar on signup error', (
    WidgetTester tester,
  ) async {
    // Arrange
    whenListen(
      mockViewModel,
      Stream.fromIterable([
        SignUpStates(signUpState: BaseState(isLoading: true)),
        SignUpStates(
          signUpState: BaseState(
            isLoading: false,
            errorMessage: 'Signup Failed',
          ),
        ),
      ]),
      initialState: SignUpStates(),
    );

    // Act
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump();
    await tester.pump();

    // Assert
    expect(find.text('Signup Failed'), findsOneWidget);
  });
}
