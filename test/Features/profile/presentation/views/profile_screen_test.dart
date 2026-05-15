import 'dart:ui';
import 'package:bloc_test/bloc_test.dart';
import 'package:flowers_app/Features/notifications/presentation/view_model/notification_event.dart';
import 'package:flowers_app/Features/notifications/presentation/view_model/notification_state.dart';
import 'package:flowers_app/Features/notifications/presentation/view_model/notification_view_model.dart';
import 'package:flowers_app/Features/profile/presentation/view_model/profile_event.dart';
import 'package:flowers_app/Features/profile/presentation/view_model/profile_state.dart';
import 'package:flowers_app/Features/profile/presentation/view_model/profile_view_model.dart';
import 'package:flowers_app/Features/profile/presentation/views/profile_screen.dart';
import 'package:flowers_app/core/l10n/view_model/language_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
 import 'package:flowers_app/core/l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MockProfileViewModel extends MockBloc<ProfileEvent, ProfileState> implements ProfileViewModel {}
class MockNotificationViewModel extends MockBloc<NotificationEvent, NotificationState> implements NotificationViewModel {}
class MockLanguageCubit extends MockCubit<Locale> implements LanguageCubit {}

void main() {
  late MockProfileViewModel mockProfileVM;
  late MockNotificationViewModel mockNotificationVM;
  late MockLanguageCubit mockLanguageCubit;

  setUpAll(() {
    registerFallbackValue(GetProfileEvent());
    registerFallbackValue(GetNotificationsEvent());
    registerFallbackValue(const Locale('en'));
  });

  setUp(() {
    mockProfileVM = MockProfileViewModel();
    mockNotificationVM = MockNotificationViewModel();
    mockLanguageCubit = MockLanguageCubit();

    when(() => mockProfileVM.state).thenReturn(ProfileState());
    when(() => mockNotificationVM.state).thenReturn(NotificationState());
    when(() => mockLanguageCubit.state).thenReturn(const Locale('en'));
  });

  testWidgets('should render profile screen without localization error', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiBlocProvider(
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
          locale: Locale('en'),
           home: ProfileScreen(),
        ),
      ),
    );

    await tester.pumpAndSettle(); // ننتظر استقرار الـ UI والـ Callbacks

    expect(find.byType(ProfileScreen), findsOneWidget);
  });
}