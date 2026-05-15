import 'package:flowers_app/Features/track_order/domain/entities/order_status.dart';
import 'package:flowers_app/core/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('OrderStatus Enum Comprehensive Tests', () {
    test('fromFirebase mapping should be accurate for all defined values', () {
      final expectations = {
        'accepted': OrderStatus.accepted,
        'arrived_pickup': OrderStatus.arrivedPickup,
        'start_deliver': OrderStatus.outForDelivery,
        'arrived_user': OrderStatus.arrivedUser,
        'delivered': OrderStatus.delivered,
      };

      expectations.forEach((firebaseValue, expectedStatus) {
        expect(
          OrderStatusX.fromFirebase(firebaseValue),
          expectedStatus,
          reason: 'Failed for firebase value: $firebaseValue',
        );
      });
    });

    test(
      'fromFirebase should return default status for invalid or null values',
      () {
        expect(
          OrderStatusX.fromFirebase('random_string'),
          OrderStatus.accepted,
        );
        expect(OrderStatusX.fromFirebase(''), OrderStatus.accepted);
      },
    );

    group('Localization Strings Comprehensive Tests', () {
      // ميثود مساعدة لإنشاء بيئة الاختبار وتكرار الفحص على كل الحالات
      Future<void> testAllStatuses(
        WidgetTester tester,
        String Function(OrderStatus status, BuildContext context) getter,
      ) async {
        await tester.pumpWidget(
          MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: Builder(
              builder: (context) {
                for (var status in OrderStatus.values) {
                  final text = getter(status, context);
                  expect(text, isA<String>());
                  expect(
                    text,
                    isNotEmpty,
                    reason: 'Text for ${status.name} is empty',
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        );
      }

      testWidgets(
        'getDisplayName should return valid strings for all statuses',
        (tester) async {
          await testAllStatuses(
            tester,
            (status, context) => status.getDisplayName(context),
          );
        },
      );

      testWidgets(
        'getNotificationBody should return valid strings for all statuses',
        (tester) async {
          await testAllStatuses(
            tester,
            (status, context) => status.getNotificationBody(context),
          );
        },
      );
    });

    test('firebaseValue property should match the expected API strings', () {
      expect(OrderStatus.accepted.firebaseValue, 'accepted');
      expect(OrderStatus.arrivedPickup.firebaseValue, 'arrived_pickup');
      expect(OrderStatus.outForDelivery.firebaseValue, 'start_deliver');
      expect(OrderStatus.arrivedUser.firebaseValue, 'arrived_user');
      expect(OrderStatus.delivered.firebaseValue, 'delivered');
    });
  });
}
