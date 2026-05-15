import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flowers_app/Features/track_order/presentation/widgets/track_order_shimmer.dart';
import 'package:flowers_app/core/widget/app_shimmer.dart';

void main() {
  testWidgets('TrackOrderShimmer builds correctly', (tester) async {
    // Arrange
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TrackOrderShimmer(),
        ),
      ),
    );

    // Act
    await tester.pump();

    // Assert:

    expect(find.byType(AppShimmer), findsWidgets);

     expect(find.byType(SizedBox), findsWidgets);

     expect(find.byType(Divider), findsOneWidget);
  });
}