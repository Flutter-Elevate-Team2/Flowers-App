import 'dart:io';
import 'package:bloc_test/bloc_test.dart';
import 'package:flowers_app/Features/notifications/presentation/view_model/notification_state.dart';
import 'package:flowers_app/Features/notifications/presentation/view_model/notification_view_model.dart';
import 'package:flowers_app/Features/profile/domain/entities/user_entity.dart';
import 'package:flowers_app/Features/profile/presentation/view_model/profile_event.dart';
import 'package:flowers_app/Features/profile/presentation/view_model/profile_state.dart';
import 'package:flowers_app/Features/profile/presentation/view_model/profile_view_model.dart';
import 'package:flowers_app/Features/profile/presentation/widgets/guest_profile_view.dart';
import 'package:flowers_app/Features/profile/presentation/widgets/profile_header.dart';
import 'package:flowers_app/Features/profile/presentation/widgets/profile_header_shimmer.dart';
import 'package:flowers_app/Features/profile/presentation/widgets/profile_screen_body.dart';
import 'package:flowers_app/core/base_states/base_states.dart';
import 'package:flowers_app/core/l10n/view_model/language_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flowers_app/core/l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MockProfileViewModel extends MockBloc<ProfileEvent, ProfileState> implements ProfileViewModel {}
class MockNotificationViewModel extends MockBloc<dynamic, NotificationState> implements NotificationViewModel {}
class MockLanguageCubit extends MockCubit<Locale> implements LanguageCubit {}

void main() {
  late MockProfileViewModel mockProfileVM;
  late MockNotificationViewModel mockNotificationVM;
  late MockLanguageCubit mockLanguageCubit;

  setUp(() {
    mockProfileVM = MockProfileViewModel();
    mockNotificationVM = MockNotificationViewModel();
    mockLanguageCubit = MockLanguageCubit();

    when(() => mockNotificationVM.state).thenReturn(NotificationState(unreadCount: 0));
    when(() => mockLanguageCubit.state).thenReturn(const Locale('en'));
  });

  Widget createWidgetUnderTest() {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProfileViewModel>.value(value: mockProfileVM),
        BlocProvider<NotificationViewModel>.value(value: mockNotificationVM),
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
        home: Scaffold(body: ProfileScreenBody()),
      ),
    );
  }

  group('ProfileScreenBody UI Logic Tests', () {

    testWidgets('should display ProfileHeaderShimmer when state is loading', (tester) async {
      when(() => mockProfileVM.state).thenReturn(
        ProfileState(profileState: BaseState(isLoading: true)),
      );

      await tester.pumpWidget(createWidgetUnderTest());
      expect(find.byType(ProfileHeaderShimmer), findsOneWidget);
    });

    testWidgets('should display GuestProfileView when user is not authenticated', (tester) async {
      when(() => mockProfileVM.state).thenReturn(
        ProfileState(
            profileState: BaseState(
                isLoading: false,
                data: null,
                errorMessage: null
            )
        ),
      );

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      expect(find.byType(GuestProfileView), findsOneWidget);
      expect(find.byIcon(Icons.login), findsOneWidget);
    });

    testWidgets('should display error message when loading profile fails', (tester) async {
      const errorMsg = "Connection Error";
      when(() => mockProfileVM.state).thenReturn(
        ProfileState(profileState: BaseState(isLoading: false, errorMessage: errorMsg)),
      );

      await tester.pumpWidget(createWidgetUnderTest());
      expect(find.text(errorMsg), findsOneWidget);
    });

    testWidgets('should display user data when profile is loaded successfully', (tester) async {
      final mockUser = UserEntity(
        firstName: "Ahmed",
        lastName: "Ali",
        email: "ahmed@example.com",
        phone: "0123456789",
        gender: "male",
        id: '1',
        photoUrl: '',
        role: 'user',
      );

      when(() => mockProfileVM.state).thenReturn(
        ProfileState(profileState: BaseState(isLoading: false, data: mockUser)),
      );

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      expect(find.byType(ProfileHeader), findsOneWidget);
      expect(find.textContaining('Ahmed'), findsWidgets);
    });

    testWidgets('should update notification badge count in AppBar', (tester) async {
      when(() => mockProfileVM.state).thenReturn(
        ProfileState(profileState: BaseState(isLoading: false, data: null)),
      );
      when(() => mockNotificationVM.state).thenReturn(
        NotificationState(unreadCount: 15),
      );

      await tester.pumpWidget(createWidgetUnderTest());
      expect(find.text('15'), findsOneWidget);
    });
  });
}