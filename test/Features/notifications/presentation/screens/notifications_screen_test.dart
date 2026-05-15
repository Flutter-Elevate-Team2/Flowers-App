import 'package:flowers_app/Features/notifications/domain/entities/notification_entity.dart';
import 'package:flowers_app/Features/notifications/presentation/view_model/notification_state.dart';
import 'package:flowers_app/Features/notifications/presentation/view_model/notification_view_model.dart';
import 'package:flowers_app/Features/notifications/presentation/widgets/notification_item.dart';
import 'package:flowers_app/Features/notifications/presentation/widgets/notifications_screen_body.dart';
import 'package:flowers_app/Features/notifications/presentation/widgets/notification_empty_widget.dart';
import 'package:flowers_app/Features/notifications/presentation/widgets/notification_error_screen.dart';
import 'package:flowers_app/Features/notifications/presentation/widgets/notifications_shimmer.dart';
import 'package:flowers_app/core/base_states/base_states.dart';
import 'package:flowers_app/core/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'notifications_screen_test.mocks.dart';

@GenerateMocks([NotificationViewModel])
void main() {
  late MockNotificationViewModel mockViewModel;

  setUp(() {
    mockViewModel = MockNotificationViewModel();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('en'),
      home: BlocProvider<NotificationViewModel>.value(
        value: mockViewModel,
        child: const Scaffold(body: NotificationScreenBody()),
      ),
    );
  }

  final now = DateTime(2026, 3, 1);

  group('NotificationScreenBody', () {
    testWidgets('shows shimmer when notificationsState is null', (
      tester,
    ) async {
      // Arrange – initial state has null notificationsState
      final state = NotificationState();
      when(mockViewModel.state).thenReturn(state);
      when(
        mockViewModel.stream,
      ).thenAnswer((_) => Stream<NotificationState>.value(state));

      // Act
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      // Assert
      expect(find.byType(NotificationShimmer), findsOneWidget);
    });

    testWidgets('shows shimmer when loading', (tester) async {
      // Arrange
      final state = NotificationState(
        notificationsState: BaseState(isLoading: true),
      );
      when(mockViewModel.state).thenReturn(state);
      when(
        mockViewModel.stream,
      ).thenAnswer((_) => Stream<NotificationState>.value(state));

      // Act
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      // Assert
      expect(find.byType(NotificationShimmer), findsOneWidget);
    });

    testWidgets('shows error screen when errorMessage is present', (
      tester,
    ) async {
      // Arrange
      final state = NotificationState(
        notificationsState: BaseState(
          isLoading: false,
          errorMessage: 'Something went wrong',
        ),
      );
      when(mockViewModel.state).thenReturn(state);
      when(
        mockViewModel.stream,
      ).thenAnswer((_) => Stream<NotificationState>.value(state));

      // Act
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      // Assert
      expect(find.byType(NotificationError), findsOneWidget);
    });

    testWidgets('shows empty widget when list is empty', (tester) async {
      // Arrange
      final state = NotificationState(
        notificationsState: BaseState(
          isLoading: false,
          data: <NotificationEntity>[],
        ),
      );
      when(mockViewModel.state).thenReturn(state);
      when(
        mockViewModel.stream,
      ).thenAnswer((_) => Stream<NotificationState>.value(state));

      // Act
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      // Assert
      expect(find.byType(NotificationEmpty), findsOneWidget);
    });

    testWidgets('shows notification items when data is present', (
      tester,
    ) async {
      // Arrange
      final notifications = [
        NotificationEntity(
          id: '1',
          title: 'Order Shipped',
          body: 'Your order is on the way',
          isRead: false,
          sentAt: now,
        ),
        NotificationEntity(
          id: '2',
          title: 'Welcome',
          body: 'Thanks for joining',
          isRead: true,
          sentAt: now,
        ),
      ];
      final state = NotificationState(
        notificationsState: BaseState(isLoading: false, data: notifications),
      );
      when(mockViewModel.state).thenReturn(state);
      when(
        mockViewModel.stream,
      ).thenAnswer((_) => Stream<NotificationState>.value(state));

      // Act
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      // Assert
      expect(find.byType(NotificationItem), findsNWidgets(2));
      expect(find.text('Order Shipped'), findsOneWidget);
      expect(find.text('Welcome'), findsOneWidget);
    });
  });
}
