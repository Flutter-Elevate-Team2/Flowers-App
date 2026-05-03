import 'package:flowers_app/Features/track_order/presentation/widgets/map/map_markers_overlay.dart';
 import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  late ValueNotifier<Offset?> driverOffset;
  late ValueNotifier<Offset?> storeOffset;
  late ValueNotifier<Offset?> userOffset;

  setUp(() {
    driverOffset = ValueNotifier<Offset?>(const Offset(100, 100));
    storeOffset = ValueNotifier<Offset?>(const Offset(200, 200));
    userOffset = ValueNotifier<Offset?>(const Offset(300, 300));
  });

  Widget createWidgetUnderTest({String? driverImageUrl}) {
    return MaterialApp(
      home: Scaffold(
        body: MapMarkersOverlay(
          driverOffset: driverOffset,
          storeOffset: storeOffset,
          userOffset: userOffset,
          driverImageUrl: driverImageUrl,
        ),
      ),
    );
  }

  group('MapMarkersOverlay Widget Tests', () {
    testWidgets('should render all markers when offsets are provided', (tester) async {
      // arrange
      await tester.pumpWidget(createWidgetUnderTest());

      // act
      await tester.pump();

      // assert
      expect(find.byType(Image), findsNWidgets(3));
    });

    testWidgets('should hide markers when offsets are null', (tester) async {
      // arrange
      driverOffset.value = null;
      storeOffset.value = null;
      userOffset.value = null;

      // act
      await tester.pumpWidget(createWidgetUnderTest());

      // assert
      expect(find.byType(Image), findsNothing);
    });

    testWidgets('should render network image for driver when url is provided', (tester) async {
      // arrange
      const imageUrl = 'https://example.com/driver.png';

      await mockNetworkImagesFor(() async {
        // act
        await tester.pumpWidget(createWidgetUnderTest(driverImageUrl: imageUrl));
        await tester.pump();

        // assert
        final imageFinder = find.byType(Image);
        final networkImage = tester.widget<Image>(imageFinder.first);
        expect(networkImage.image, isA<NetworkImage>());
      });
    });

    testWidgets('should animate driver marker position when offset changes', (tester) async {
      // arrange
      await tester.pumpWidget(createWidgetUnderTest());

      // act
      driverOffset.value = const Offset(150, 150);
      await tester.pump(); // Start animation
      await tester.pump(const Duration(milliseconds: 150)); // Mid animation

      // assert
      final animatedPositioned = tester.widget<AnimatedPositioned>(
        find.byType(AnimatedPositioned),
      );
      expect(animatedPositioned.duration, const Duration(milliseconds: 300));

      await tester.pumpAndSettle();
    });

    testWidgets('should display asset images for store and user markers', (tester) async {
      // arrange
      await tester.pumpWidget(createWidgetUnderTest());

      // act
      await tester.pump();

      // assert
      expect(find.byType(Image), findsAtLeastNWidgets(2));
      final assetImages = tester.widgetList<Image>(find.byType(Image));
      expect(
        assetImages.any((img) => img.image is AssetImage),
        isTrue,
      );
    });
  });
}