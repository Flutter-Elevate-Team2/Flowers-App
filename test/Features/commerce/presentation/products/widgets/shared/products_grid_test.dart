import 'package:bloc_test/bloc_test.dart';
import 'package:flowers_app/Features/commerce/domain/entities/product_entities/product_entity.dart';
import 'package:flowers_app/Features/commerce/presentation/products/widgets/shared/product_card/product_card.dart';
import 'package:flowers_app/Features/commerce/presentation/products/widgets/shared/products_grid.dart';
import 'package:flowers_app/Features/order/presentation/cart/view_model/cart_states.dart';
import 'package:flowers_app/Features/order/presentation/cart/view_model/cart_view_model.dart';
import 'package:flowers_app/core/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCartViewModel extends MockCubit<CartStates>
    implements CartViewModel {}

void main() {
  late MockCartViewModel mockCartViewModel;
  late List<ProductEntity> testProducts;

  setUp(() {
    mockCartViewModel = MockCartViewModel();
    testProducts = List.generate(
      4,
      (index) => ProductEntity(
        id: '$index',
        title: 'Product $index',
        slug: 'slug-$index',
        description: 'desc',
        imgCover: 'https://placeholder.com/img.jpg', // URL وهمي
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
      ),
    );

    when(() => mockCartViewModel.state).thenReturn(const CartStates());
  });

  Widget createWidgetUnderTest({
    required List<ProductEntity> products,
    bool isLoadingMore = false,
  }) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: BlocProvider<CartViewModel>.value(
          value: mockCartViewModel,
          child: ProductsGrid(products: products, isLoadingMore: isLoadingMore),
        ),
      ),
    );
  }

  group('ProductsGrid Widget Tests', () {
    testWidgets('Initial State: renders correct number of ProductCards', (
      tester,
    ) async {
      // ضبط الشاشة لتكون كبيرة بما يكفي لعرض الـ 4 كروت
      tester.view.physicalSize = const Size(1200, 2400);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(createWidgetUnderTest(products: testProducts));

      // ✅ استخدمنا pump بدلاً من pumpAndSettle لتجنب الـ Timeout بسبب الأنيميشن
      await tester.pump();

      expect(find.byType(ProductCard), findsNWidgets(testProducts.length));

      addTearDown(tester.view.resetPhysicalSize);
    });

    testWidgets(
      'Loading State: renders CircularProgressIndicator when isLoadingMore is true',
      (tester) async {
        tester.view.physicalSize = const Size(1200, 2400);

        await tester.pumpWidget(
          createWidgetUnderTest(products: testProducts, isLoadingMore: true),
        );

        // ✅ نستخدم pump(Duration) لتحريك الأنيميشن قليلاً
        await tester.pump(const Duration(milliseconds: 100));

        // البحث عن الـ Loading في الـ GridView
        final loaderFinder = find.byType(CircularProgressIndicator);

        // إذا كان الـ GridView كبير جداً، قد نحتاج للسكرول
        await tester.dragUntilVisible(
          loaderFinder,
          find.byType(GridView),
          const Offset(0, -300),
        );
        await tester.pump();

        expect(loaderFinder, findsOneWidget);
        addTearDown(tester.view.resetPhysicalSize);
      },
    );
  });
}
