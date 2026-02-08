import 'package:flowers_app/Features/notifications/domain/entities/notification_entity.dart';
import 'package:flowers_app/Features/notifications/presentation/widgets/notification_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('NotificationItem displays title and body correctly', (
    WidgetTester tester,
  ) async {
    final notification = NotificationEntity(
      title: 'Test Title',
      body: 'Test Body',
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: NotificationItem(notification: notification)),
      ),
    );

    expect(find.text('Test Title'), findsOneWidget);
    expect(find.text('Test Body'), findsOneWidget);
    expect(find.byIcon(Icons.notifications_none_outlined), findsOneWidget);
  });
}
