import 'package:bloc_test/bloc_test.dart';
import 'package:flowers_app/Features/commerce/domain/entities/product_entities/product_entity.dart';
import 'package:flowers_app/Features/commerce/presentation/products/widgets/occasions/occasion_products_list.dart';
import 'package:flowers_app/Features/commerce/presentation/products/widgets/shared/products_grid.dart';
import 'package:flowers_app/Features/commerce/presentation/products/widgets/shimmers/products_grid_shimmer.dart';
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
    testProducts = [
      ProductEntity(
        id: '1',
        title: 'P1',
        slug: 's1',
        description: 'd',
        imgCover: 'i',
        images: [],
        price: 10,
        priceAfterDiscount: 8,
        quantity: 5,
        categoryId: 'c',
        occasionId: 'o',
        sold: 0,
        rateAvg: 0,
        rateCount: 0,
        isInWishlist: false,
        discount: 2,
      ),
    ];

    when(() => mockCartViewModel.state).thenReturn(const CartStates());
  });

  Widget createWidgetUnderTest({
    required List<ProductEntity> products,
    required bool isPaginationLoading,
  }) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: BlocProvider<CartViewModel>.value(
          value: mockCartViewModel,
          child: OccasionProductsList(
            products: products,
            isPaginationLoading: isPaginationLoading,
            scrollController: ScrollController(),
          ),
        ),
      ),
    );
  }

  group('OccasionProductsList Widget Tests', () {
    testWidgets('Initial State: renders ProductsGrid with products', (
      tester,
    ) async {
      await tester.pumpWidget(
        createWidgetUnderTest(
          products: testProducts,
          isPaginationLoading: false,
        ),
      );

      expect(find.byType(ProductsGrid), findsOneWidget);
      expect(find.byType(ProductsGridShimmer), findsNothing);
    });

    testWidgets(
      'Loading State: renders ProductsGridShimmer when isPaginationLoading is true',
      (tester) async {
        tester.view.physicalSize = const Size(1080, 2400);
        tester.view.devicePixelRatio = 1.0;

        await tester.pumpWidget(
          createWidgetUnderTest(
            products: testProducts,
            isPaginationLoading: true,
          ),
        );

        await tester.pump(const Duration(milliseconds: 100));

        final shimmerFinder = find.byType(ProductsGridShimmer);

        expect(find.byType(ProductsGrid), findsOneWidget);
        expect(shimmerFinder, findsOneWidget);

        addTearDown(tester.view.resetPhysicalSize);
      },
    );
  });
}
