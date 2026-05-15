import 'package:bloc_test/bloc_test.dart';
import 'package:flowers_app/Features/profile/domain/entities/change_password_entity.dart';
import 'package:flowers_app/Features/profile/presentation/view_model/profile_event.dart';
import 'package:flowers_app/Features/profile/presentation/view_model/profile_state.dart';
import 'package:flowers_app/Features/profile/presentation/view_model/profile_view_model.dart';
import 'package:flowers_app/Features/profile/presentation/widgets/reset_password_screen_body.dart';
import 'package:flowers_app/core/base_states/base_states.dart';
import 'package:flowers_app/core/l10n/view_model/language_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flowers_app/core/l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MockProfileViewModel extends MockBloc<ProfileEvent, ProfileState> implements ProfileViewModel {}
class MockLanguageCubit extends MockCubit<Locale> implements LanguageCubit {}

void main() {
  late MockProfileViewModel mockProfileVM;
  late MockLanguageCubit mockLanguageCubit;

  setUpAll(() {
    registerFallbackValue(ChangePasswordEvent(oldPassword: '', newPassword: ''));
  });

  setUp(() {
    mockProfileVM = MockProfileViewModel();
    mockLanguageCubit = MockLanguageCubit();

    when(() => mockProfileVM.state).thenReturn(ProfileState());
    when(() => mockLanguageCubit.state).thenReturn(const Locale('en'));
  });

  Widget createWidgetUnderTest() {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProfileViewModel>.value(value: mockProfileVM),
        BlocProvider<LanguageCubit>.value(value: mockLanguageCubit),
      ],
      child: const MaterialApp(
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [Locale('en'), Locale('ar')],
        home: const ResetPasswordScreenBody(),
      ),
    );
  }

  group('ResetPasswordScreenBody Tests', () {
    testWidgets('should show validation errors when fields are empty and button is pressed', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      final updateButton = find.byType(ElevatedButton);
      await tester.tap(updateButton);
      await tester.pumpAndSettle();

      expect(find.textContaining('required'), findsWidgets);
      verifyNever(() => mockProfileVM.doIntent(any()));
    });

    testWidgets('should show loading indicator when state is loading', (tester) async {
      when(() => mockProfileVM.state).thenReturn(
        ProfileState(changePasswordState: BaseState(isLoading: true)),
      );

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should show error SnackBar when changePasswordState has error', (tester) async {
      final stateWithError = ProfileState(
        changePasswordState: BaseState(isLoading: false, errorMessage: 'Invalid Old Password'),
      );

      whenListen(
        mockProfileVM,
        Stream.fromIterable([ProfileState(), stateWithError]),
        initialState: ProfileState(),
      );

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Invalid Old Password'), findsOneWidget);
    });

    testWidgets('should call changePassword event when form is valid', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      await tester.enterText(find.byType(TextFormField).at(0), 'OldPass123!');
      await tester.enterText(find.byType(TextFormField).at(1), 'NewPass123!');
      await tester.enterText(find.byType(TextFormField).at(2), 'NewPass123!');

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      verify(() => mockProfileVM.doIntent(any(that: isA<ChangePasswordEvent>()))).called(1);
    });
  });
}