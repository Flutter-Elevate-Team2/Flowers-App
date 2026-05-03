import 'package:flowers_app/Features/track_order/presentation/widgets/state_time_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget createWidget({
    bool isActive = false,
    bool isLast = false,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: StateTimeLine(
          title: "Order received",
          time: "06 Mar 2026, 12:30 PM",
          isActive: isActive,
          isLast: isLast,
          currentIndex: 1,
        ),
      ),
    );
  }

  group("StateTimeLine Widget Tests", () {

    testWidgets("should render title and time", (tester) async {
      await tester.pumpWidget(createWidget());

      expect(find.text("Order received"), findsOneWidget);
      expect(find.text("06 Mar 2026, 12:30 PM"), findsOneWidget);
    });

    testWidgets("should render timeline widget", (tester) async {
      await tester.pumpWidget(createWidget());

      expect(find.byType(StateTimeLine), findsOneWidget);
      expect(find.byType(Container), findsWidgets);
    });

    testWidgets("should render active state when isActive = true", (tester) async {
      await tester.pumpWidget(createWidget(isActive: true));

      final text = tester.widget<Text>(find.text("Order received"));

      expect(text.style!.fontWeight, FontWeight.w600);
    });

    testWidgets("should render inactive state when isActive = false", (tester) async {
      await tester.pumpWidget(createWidget(isActive: false));

      final text = tester.widget<Text>(find.text("Order received"));

      expect(text.style!.fontWeight, FontWeight.normal);
    });

    testWidgets("should hide line when isLast = true", (tester) async {
      await tester.pumpWidget(createWidget(isLast: true));

      final expandedFinder = find.byType(Expanded);

       expect(expandedFinder, findsOneWidget);
    });

  });
}