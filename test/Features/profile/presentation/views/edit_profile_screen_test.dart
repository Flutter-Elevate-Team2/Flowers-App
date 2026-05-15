import 'package:bloc_test/bloc_test.dart';
import 'package:flowers_app/Features/profile/data/models/edit_profile_request.dart';
import 'package:flowers_app/Features/profile/domain/entities/user_entity.dart';
import 'package:flowers_app/Features/profile/presentation/view_model/profile_event.dart';
import 'package:flowers_app/Features/profile/presentation/view_model/profile_state.dart';
import 'package:flowers_app/Features/profile/presentation/view_model/profile_view_model.dart';
import 'package:flowers_app/Features/profile/presentation/views/edit_profile_screen.dart';
 import 'package:flowers_app/Features/profile/presentation/widgets/update_profile_buttom.dart';
import 'package:flowers_app/Features/profile/presentation/widgets/edit_profile_shimmer.dart';
import 'package:flowers_app/core/base_states/base_states.dart';
import 'package:flowers_app/core/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockProfileViewModel extends MockBloc<ProfileEvent, ProfileState> implements ProfileViewModel {}

void main() {
  late MockProfileViewModel mockProfileVM;

  final tUser = UserEntity(
    id: '1',
    firstName: 'John',
    lastName: 'Doe',
    email: 'john@test.com',
    phone: '0123456789',
    photoUrl: '',
    role: 'user',
    gender: 'male',
  );

  setUpAll(() {
    // التصحيح هنا: نرسل Instance حقيقي وليس Matcher
    registerFallbackValue(GetProfileEvent());
    registerFallbackValue(EditProfileEvent(EditProfileRequest(
      firstName: '',
      lastName: '',
      email: '',
      phone: '',
    )));
  });

  setUp(() {
    mockProfileVM = MockProfileViewModel();
  });

  Widget createWidgetUnderTest() {
    return BlocProvider<ProfileViewModel>.value(
      value: mockProfileVM,
      child: MaterialApp(
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('en'), Locale('ar')],
        home: const EditProfileScreen(),
      ),
    );
  }

  group('EditProfileScreen Widget Tests', () {
    testWidgets('should show EditProfileShimmer when profile is loading', (tester) async {
      when(() => mockProfileVM.state).thenReturn(
        ProfileState(profileState: BaseState(isLoading: true)),
      );

      await tester.pumpWidget(createWidgetUnderTest());
      expect(find.byType(EditProfileShimmer), findsOneWidget);
    });

    testWidgets('should populate text controllers with user data when profile is loaded', (tester) async {
      when(() => mockProfileVM.state).thenReturn(
        ProfileState(profileState: BaseState(isLoading: false, data: tUser)),
      );

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      expect(find.text('John'), findsOneWidget);
      expect(find.text('Doe'), findsOneWidget);
    });

    testWidgets('should trigger EditProfileEvent when update button is pressed', (tester) async {
      when(() => mockProfileVM.state).thenReturn(
        ProfileState(profileState: BaseState(isLoading: false, data: tUser)),
      );

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      await tester.tap(find.byType(UpdateProfileButton));
      await tester.pump();

      verify(() => mockProfileVM.doIntent(any(that: isA<EditProfileEvent>()))).called(1);
    });

    testWidgets('should show validation errors if fields are empty', (tester) async {
      when(() => mockProfileVM.state).thenReturn(
        ProfileState(profileState: BaseState(isLoading: false, data: tUser)),
      );

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextFormField).first, '');
      await tester.tap(find.byType(UpdateProfileButton));
      await tester.pump();

      expect(find.text('Required'), findsAtLeastNWidgets(1));
    });
  });
}