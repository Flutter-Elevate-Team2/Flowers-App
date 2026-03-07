import 'package:flowers_app/Features/notifications/presentation/view_model/notification_view_model.dart';
import 'package:flowers_app/Features/notifications/presentation/view_model/notification_state.dart';
import 'package:flowers_app/Features/notifications/presentation/views/notification_screen.dart';
import 'package:flowers_app/Features/notifications/presentation/widgets/notifications_screen_body.dart';
import 'package:flowers_app/core/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

 @GenerateMocks([NotificationViewModel])
import 'notification_screen_test.mocks.dart';

void main() {
  late MockNotificationViewModel mockViewModel;

  setUp(() {
    mockViewModel = MockNotificationViewModel();

    when(mockViewModel.state).thenReturn(NotificationState());
    when(mockViewModel.stream).thenAnswer((_) => const Stream.empty());
  });

  Widget createNotificationScreen() {
    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: BlocProvider<NotificationViewModel>.value(
        value: mockViewModel,
        child: const NotificationScreen(),
      ),
    );
  }

  testWidgets('should render NotificationScreen successfully when ViewModel is provided',          (WidgetTester tester) async {
        // Act
        await tester.pumpWidget(createNotificationScreen());
        await tester.pump();

        // Assert
        expect(find.byType(NotificationScreen), findsOneWidget);
        expect(find.byType(NotificationScreenBody), findsOneWidget);
      });
}