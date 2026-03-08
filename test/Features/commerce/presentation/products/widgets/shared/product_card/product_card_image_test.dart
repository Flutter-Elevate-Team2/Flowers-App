import 'package:cached_network_image/cached_network_image.dart';
import 'package:flowers_app/Features/commerce/presentation/products/widgets/shared/product_card/product_card_image.dart';
import 'package:flowers_app/core/l10n/app_localizations.dart';
import 'package:flowers_app/core/widget/app_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget createWidgetUnderTest({required String imgCover}) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(body: ProductCardImage(imgCover: imgCover, height: 200)),
    );
  }

  group('ProductCardImage Widget Tests', () {
    testWidgets('Initial State: renders correctly with CachedNetworkImage', (
      tester,
    ) async {
      const imageUrl = 'https://example.com/image.jpg';
      await tester.pumpWidget(createWidgetUnderTest(imgCover: imageUrl));

      expect(find.byType(CachedNetworkImage), findsOneWidget);
      final CachedNetworkImage image = tester.widget(
        find.byType(CachedNetworkImage),
      );
      expect(image.imageUrl, imageUrl);
    });

    testWidgets('Loading State: shows placeholder when loading', (
      tester,
    ) async {
      // In widget tests, CachedNetworkImage usually shows the placeholder immediately if not mocked
      await tester.pumpWidget(
        createWidgetUnderTest(imgCover: 'https://example.com/image.jpg'),
      );

      // We can't easily force CachedNetworkImage state without mocking its provider,
      // but we can check if placeholder builder returns AppShimmer
      final image = tester.widget<CachedNetworkImage>(
        find.byType(CachedNetworkImage),
      );
      final placeholder = image.placeholder!(
        tester.element(find.byType(CachedNetworkImage)),
        'url',
      );

      expect(placeholder, isA<AppShimmer>());
    });

    testWidgets('Error State: shows error widget on failure', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest(imgCover: 'invalid-url'));

      final image = tester.widget<CachedNetworkImage>(
        find.byType(CachedNetworkImage),
      );

      final errorWidget = image.errorWidget!(
        tester.element(find.byType(CachedNetworkImage)),
        'url',
        'error',
      );

      await tester.pumpWidget(MaterialApp(home: Scaffold(body: errorWidget)));

      expect(find.byIcon(Icons.image_not_supported_outlined), findsOneWidget);

      expect(
        find.ancestor(
          of: find.byIcon(Icons.image_not_supported_outlined),
          matching: find.byType(Center),
        ),
        findsOneWidget,
      );
    });
  });
}
