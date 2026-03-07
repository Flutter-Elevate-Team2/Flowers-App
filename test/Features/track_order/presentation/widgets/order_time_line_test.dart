import 'package:flowers_app/Features/track_order/presentation/widgets/order_time_line.dart';
import 'package:flowers_app/Features/track_order/presentation/widgets/state_time_line.dart';
import 'package:flowers_app/core/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

void main() {
  final testHistory = {
    "arrived_pickup": DateTime(2026, 3, 6, 12, 30),
    "start_deliver": DateTime(2026, 3, 6, 13, 00),
    "arrived_user": DateTime(2026, 3, 6, 13, 30),
    "delivered": DateTime(2026, 3, 6, 14, 00),
  };

  Widget createWidget() {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: OrderTimeline(
          currentStatus: "delivered",
          history: testHistory,
        ),
      ),
    );
  }

  group("OrderTimeline Widget Test", () {

    testWidgets("should render OrderTimeline widget", (tester) async {
      await tester.pumpWidget(createWidget());

      expect(find.byType(OrderTimeline), findsOneWidget);
    });

    testWidgets("should render 4 timeline states", (tester) async {
      await tester.pumpWidget(createWidget());

      expect(find.byType(StateTimeLine), findsNWidgets(4));
    });

    testWidgets("should display formatted times", (tester) async {
      await tester.pumpWidget(createWidget());

      final formatted =
      DateFormat('dd MMM yyyy, hh:mm a').format(testHistory["delivered"]!);

      expect(find.text(formatted), findsOneWidget);
    });

  });
}