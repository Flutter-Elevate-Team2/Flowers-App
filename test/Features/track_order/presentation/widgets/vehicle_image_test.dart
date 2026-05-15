import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flowers_app/Features/track_order/presentation/widgets/vehicle_image.dart';
import 'package:flowers_app/core/widget/app_shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';

void main() {
  const testUrl = 'https://example.com/vehicle.jpg';

  Widget createWidget(String url) {
    return MaterialApp(
      home: Scaffold(
        body: VehicleImage(url),
      ),
    );
  }

  testWidgets('VehicleImage builds and shows shimmer placeholder', (tester) async {
    await tester.pumpWidget(createWidget(testUrl));

     expect(find.byType(AppShimmer), findsOneWidget);

     expect(find.byType(CachedNetworkImage), findsOneWidget);
  });

  testWidgets('VehicleImage renders error widget without network', (tester) async {
     await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Icon(Icons.error),
          ),
        ),
      ),
    );

    expect(find.byIcon(Icons.error), findsOneWidget);
  });
}