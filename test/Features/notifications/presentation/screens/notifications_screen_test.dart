import 'package:flowers_app/Features/notifications/domain/entities/notification_entity.dart';
import 'package:flowers_app/Features/notifications/presentation/screens/notifications_screen.dart';
import 'package:flowers_app/Features/notifications/presentation/view_model/notification_state.dart';
import 'package:flowers_app/Features/notifications/presentation/view_model/notification_view_model.dart';
import 'package:flowers_app/Features/notifications/presentation/widgets/notification_item.dart';
import 'package:flowers_app/core/base_states/base_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'notifications_screen_test.mocks.dart';

@GenerateMocks([NotificationViewModel])
void main() {
  late MockNotificationViewModel mockViewModel;

  setUp(() {
    mockViewModel = MockNotificationViewModel();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: BlocProvider<NotificationViewModel>.value(
        value: mockViewModel,
        child: NotificationsScreen(),
      ),
    );
  }

  testWidgets('renders CircularProgressIndicator when loading', (
    WidgetTester tester,
  ) async {
    final state = NotificationState(
      notificationsState: BaseState(isLoading: true),
    );
    when(mockViewModel.state).thenReturn(state);
    when(
      mockViewModel.stream,
    ).thenAnswer((_) => Stream<NotificationState>.value(state));

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('renders error message when error occurs', (
    WidgetTester tester,
  ) async {
    final state = NotificationState(
      notificationsState: BaseState(
        isLoading: false,
        errorMessage: 'Error message',
      ),
    );
    when(mockViewModel.state).thenReturn(state);
    when(
      mockViewModel.stream,
    ).thenAnswer((_) => Stream<NotificationState>.value(state));

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump();

    expect(find.text('Error message'), findsOneWidget);
  });

  testWidgets('renders list of notifications when success', (
    WidgetTester tester,
  ) async {
    final notifications = [
      NotificationEntity(title: 'Notif 1', body: 'Body 1'),
      NotificationEntity(title: 'Notif 2', body: 'Body 2'),
    ];
    final state = NotificationState(
      notificationsState: BaseState(isLoading: false, data: notifications),
    );
    when(mockViewModel.state).thenReturn(state);
    when(
      mockViewModel.stream,
    ).thenAnswer((_) => Stream<NotificationState>.value(state));

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump();

    expect(find.byType(NotificationItem), findsNWidgets(2));
    expect(find.text('Notif 1'), findsOneWidget);
    expect(find.text('Notif 2'), findsOneWidget);
  });

  testWidgets('renders No notifications when list is empty', (
    WidgetTester tester,
  ) async {
    final state = NotificationState(
      notificationsState: BaseState(isLoading: false, data: []),
    );
    when(mockViewModel.state).thenReturn(state);
    when(
      mockViewModel.stream,
    ).thenAnswer((_) => Stream<NotificationState>.value(state));

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump();

    expect(find.text('No notifications'), findsOneWidget);
  });
}
