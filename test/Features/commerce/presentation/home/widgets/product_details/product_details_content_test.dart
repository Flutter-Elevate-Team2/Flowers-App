import 'package:flowers_app/Features/commerce/domain/entities/product_entities/product_entity.dart';
import 'package:flowers_app/Features/commerce/presentation/home/widgets/product_details/product_details_content.dart';
import 'package:flowers_app/core/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late ProductEntity testProduct;

  setUp(() {
    testProduct = ProductEntity(
      id: '1',
      title: 'Pink Rose Bouquet',
      description: 'A beautiful bouquet of pink and white roses.',
      price: 1500,
      priceAfterDiscount: 1250,
      quantity: 10,
      images: [],
      slug: '',
      imgCover: '',
      categoryId: '',
      occasionId: '',
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
      locale: const Locale('en'),
      home: Scaffold(
        body: CustomScrollView(
          slivers: [ProductDetailsContent(product: product)],
        ),
      ),
    );
  }

  AppLocalizations getL10n(WidgetTester tester) {
    final BuildContext context = tester.element(
      find.byType(ProductDetailsContent),
    );
    return AppLocalizations.of(context)!;
  }

  group('ProductDetailsContent Tests', () {
    testWidgets('renders product title, formatted price and description', (
      tester,
    ) async {
      await tester.pumpWidget(createWidgetUnderTest(testProduct));
      await tester.pumpAndSettle();

      expect(find.text('Pink Rose Bouquet'), findsOneWidget);
      expect(find.text('EGP 1,250'), findsOneWidget);
      expect(find.text(testProduct.description), findsOneWidget);
    });

    testWidgets('shows In Stock label when quantity > 0', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest(testProduct));
      await tester.pumpAndSettle();

      final l10n = getL10n(tester);

      expect(find.textContaining(l10n.status), findsOneWidget);
      expect(find.text(l10n.inStock), findsOneWidget);
    });

    testWidgets('shows Out of Stock when quantity is 0', (tester) async {
      final outOfStockProduct = testProduct.copyWith(quantity: 0);

      await tester.pumpWidget(createWidgetUnderTest(outOfStockProduct));
      await tester.pumpAndSettle();

      final l10n = getL10n(tester);
      expect(find.text(l10n.outOfStock), findsOneWidget);
    });

    testWidgets('formats large prices with commas correctly', (tester) async {
      final expensiveProduct = testProduct.copyWith(
        priceAfterDiscount: 1000000,
      );

      await tester.pumpWidget(createWidgetUnderTest(expensiveProduct));
      await tester.pumpAndSettle();

      expect(find.text('EGP 1,000,000'), findsOneWidget);
    });

    group('Bouquet Include Section', () {
      testWidgets('renders static bouquet items and section title', (
        tester,
      ) async {
        await tester.pumpWidget(createWidgetUnderTest(testProduct));

        expect(find.text('Bouquet include'), findsOneWidget);
        expect(find.text('Pink roses:15'), findsOneWidget);
        expect(find.text('White wrap'), findsOneWidget);
      });
    });
  });
}

extension on ProductEntity {
  ProductEntity copyWith({
    String? id,
    String? title,
    String? description,
    int? price,
    int? priceAfterDiscount,
    int? quantity,
  }) {
    return ProductEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      priceAfterDiscount: priceAfterDiscount ?? this.priceAfterDiscount,
      quantity: quantity ?? this.quantity,
      images: images,
      slug: slug,
      imgCover: imgCover,
      categoryId: categoryId,
      occasionId: occasionId,
      sold: sold,
      rateAvg: rateAvg,
      rateCount: rateCount,
      isInWishlist: isInWishlist,
      discount: discount,
    );
  }
}
