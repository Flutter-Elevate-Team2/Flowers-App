import 'package:flowers_app/Features/commerce/domain/entities/product_entities/product_entity.dart';
import 'package:flowers_app/Features/commerce/presentation/products/widgets/shared/product_card/product_card_price_row.dart';
import 'package:flowers_app/core/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late ProductEntity productWithDiscount;
  late ProductEntity productWithoutDiscount;

  setUp(() {
    productWithDiscount = ProductEntity(
      id: '1',
      title: 'Discounted Product',
      slug: 'slug',
      description: 'desc',
      imgCover: 'img',
      images: [],
      price: 100,
      priceAfterDiscount: 80,
      quantity: 10,
      categoryId: 'cat',
      occasionId: 'occ',
      sold: 0,
      rateAvg: 0,
      rateCount: 0,
      isInWishlist: false,
      discount: 20,
    );

    productWithoutDiscount = ProductEntity(
      id: '2',
      title: 'Regular Product',
      slug: 'slug',
      description: 'desc',
      imgCover: 'img',
      images: [],
      price: 100,
      priceAfterDiscount: 100,
      quantity: 10,
      categoryId: 'cat',
      occasionId: 'occ',
      sold: 0,
      rateAvg: 0,
      rateCount: 0,
      isInWishlist: false,
      discount: 0,
    );
  });

  Widget createWidgetUnderTest(ProductEntity product) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: ProductCardPriceRow(product: product),
      ),
    );
  }

  group('ProductCardPriceRow Widget Tests', () {
    testWidgets('Initial State: renders correctly without discount', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest(productWithoutDiscount));

      expect(find.text('EGP 100'), findsOneWidget);
      expect(find.text('0%'), findsNothing);
      expect(find.byType(TextDecoration), findsNothing); // No lineThrough decoration
    });

    testWidgets('Initial State: renders correctly with discount', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest(productWithDiscount));

      expect(find.text('EGP 80'), findsOneWidget);
      expect(find.text('100'), findsOneWidget);
      expect(find.text('20%'), findsOneWidget);

      final oldPriceText = tester.widget<Text>(find.text('100'));
      expect(oldPriceText.style?.decoration, TextDecoration.lineThrough);
    });
  });
}
