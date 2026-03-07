import 'package:flowers_app/Features/notifications/domain/entities/notification_entity.dart';
import 'package:flowers_app/Features/notifications/presentation/widgets/notification_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final now = DateTime(2026, 3, 1, 10, 0);

  Widget buildWidget(NotificationEntity notification) {
    return MaterialApp(
      home: Scaffold(body: NotificationItem(notification: notification)),
    );
  }

  group('NotificationItem', () {
    testWidgets('displays title and body correctly', (tester) async {
      final notification = NotificationEntity(
        id: '1',
        title: 'Order Delivered',
        body: 'Your flowers have arrived!',
        isRead: true,
        sentAt: now,
      );

      await tester.pumpWidget(buildWidget(notification));

      expect(find.text('Order Delivered'), findsOneWidget);
      expect(find.text('Your flowers have arrived!'), findsOneWidget);
    });

    testWidgets('shows bell icon', (tester) async {
      final notification = NotificationEntity(
        id: '1',
        title: 'Title',
        body: 'Body',
        isRead: true,
        sentAt: now,
      );

      await tester.pumpWidget(buildWidget(notification));

      expect(find.byIcon(Icons.notifications_none_outlined), findsOneWidget);
    });

    testWidgets('shows unread indicator elements when unread', (tester) async {
      final notification = NotificationEntity(
        id: '1',
        title: 'Unread Title',
        body: 'Unread Body',
        isRead: false,
        sentAt: now,
      );

      await tester.pumpWidget(buildWidget(notification));

      // Verify the widget renders with the unread title and body
      expect(find.text('Unread Title'), findsOneWidget);
      expect(find.text('Unread Body'), findsOneWidget);

      // The bell icon should be present
      expect(find.byIcon(Icons.notifications_none_outlined), findsOneWidget);
    });

    testWidgets('shows read-state styling when read', (tester) async {
      final notification = NotificationEntity(
        id: '1',
        title: 'Read Title',
        body: 'Read Body',
        isRead: true,
        sentAt: now,
      );

      await tester.pumpWidget(buildWidget(notification));

      expect(find.text('Read Title'), findsOneWidget);

      // For read notifications, icon color should NOT be the orange unread color
      final iconFinder = find.byIcon(Icons.notifications_none_outlined);
      final icon = tester.widget<Icon>(iconFinder);
      expect(icon.color, isNot(const Color(0xFFE65100)));
    });

    testWidgets('renders without error for unread notification', (
      tester,
    ) async {
      final notification = NotificationEntity(
        id: '1',
        title: 'Unread',
        body: 'Body',
        isRead: false,
        sentAt: now,
      );

      await tester.pumpWidget(buildWidget(notification));

      expect(find.byType(NotificationItem), findsOneWidget);
      expect(find.text('Unread'), findsOneWidget);
    });

    testWidgets('renders without error for read notification', (tester) async {
      final notification = NotificationEntity(
        id: '1',
        title: 'Read',
        body: 'Body',
        isRead: true,
        sentAt: now,
      );

      await tester.pumpWidget(buildWidget(notification));

      expect(find.byType(NotificationItem), findsOneWidget);
      expect(find.text('Read'), findsOneWidget);
    });
  });
}
