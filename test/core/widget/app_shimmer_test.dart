import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flowers_app/core/widget/app_shimmer.dart';

void main() {
  group('AppShimmer', () {
    testWidgets('renders Shimmer widget', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: AppShimmer(height: 100))),
      );

      expect(find.byType(Shimmer), findsOneWidget);
    });

    testWidgets('AppShimmer.circle renders with correct shape', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: AppShimmer.circle(size: 50))),
      );

      final container = tester.widget<Container>(find.byType(Container));
      final decoration = container.decoration as ShapeDecoration;
      expect(decoration.shape, isA<CircleBorder>());
    });

    testWidgets('AppShimmer.rectangle (default) renders with correct radius', (
      tester,
    ) async {
      const double radius = 20;
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: AppShimmer(height: 100, radius: radius)),
        ),
      );

      final container = tester.widget<Container>(find.byType(Container));
      final decoration = container.decoration as ShapeDecoration;
      expect(decoration.shape, isA<RoundedRectangleBorder>());

      final shape = decoration.shape as RoundedRectangleBorder;
      expect(shape.borderRadius, BorderRadius.circular(radius));
    });
  });
}
