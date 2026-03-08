import 'package:flowers_app/Features/profile/presentation/widgets/edit_profile_shimmer.dart';
import 'package:flowers_app/core/widget/app_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('EditProfileShimmer Widget Tests', () {
    testWidgets('should render all shimmer components correctly', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: EditProfileShimmer(),
          ),
        ),
      );

       expect(find.byType(AppShimmer), findsAtLeastNWidgets(1));

       expect(find.byType(SingleChildScrollView), findsOneWidget);

       final shimmerWidgets = find.byType(AppShimmer);

       expect(shimmerWidgets, findsNWidgets(10));
    });

    testWidgets('should have a circular shimmer for the avatar', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: EditProfileShimmer(),
          ),
        ),
      );

       final circularShimmer = find.byWidgetPredicate(
            (widget) => widget is AppShimmer && widget.radius >= 50,
      );

      expect(circularShimmer, findsAtLeastNWidgets(1));
    });
  });
}