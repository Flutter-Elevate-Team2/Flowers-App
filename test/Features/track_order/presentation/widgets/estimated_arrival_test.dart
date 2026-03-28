import 'package:flowers_app/Features/track_order/presentation/widgets/estimated_arrival.dart';
import 'package:flowers_app/core/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

void main() {
  final testDate = DateTime(2026, 3, 6, 14, 30);

  Widget createWidgetUnderTest() {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: EstimatedArrival(date: testDate),
      ),
    );
  }

  group('EstimatedArrival Widget Test', () {

    testWidgets('should display estimated arrival title', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.textContaining('arrival'), findsOneWidget);
    });

    testWidgets('should display formatted date', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      final formattedDate =
      DateFormat('dd MMM yyyy, hh:mm a').format(testDate);

      expect(find.text(formattedDate), findsOneWidget);
    });

    testWidgets('should render EstimatedArrival widget', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(EstimatedArrival), findsOneWidget);
    });

  });
}