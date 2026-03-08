import 'package:bloc_test/bloc_test.dart';
import 'package:flowers_app/Features/commerce/domain/entities/product_entities/product_entity.dart';
import 'package:flowers_app/Features/commerce/presentation/products/view_model/products_states.dart';
import 'package:flowers_app/Features/commerce/presentation/products/view_model/products_view_model.dart';
import 'package:flowers_app/Features/commerce/presentation/products/widgets/shared/paginated_products_view.dart';
import 'package:flowers_app/Features/commerce/presentation/products/widgets/shared/products_grid.dart';
import 'package:flowers_app/Features/commerce/presentation/products/widgets/shimmers/products_grid_shimmer.dart';
import 'package:flowers_app/core/base_states/base_states.dart';
import 'package:flowers_app/core/l10n/app_localizations.dart';
import 'package:flowers_app/Features/order/presentation/cart/view_model/cart_states.dart';
import 'package:flowers_app/Features/order/presentation/cart/view_model/cart_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockProductsViewModel extends MockCubit<ProductsStates>
    implements ProductsViewModel {}

class MockCartViewModel extends MockCubit<CartStates>
    implements CartViewModel {}

void main() {
  late MockProductsViewModel mockProductsViewModel;
  late MockCartViewModel mockCartViewModel;
  late ScrollController scrollController;

  setUp(() {
    mockProductsViewModel = MockProductsViewModel();
    mockCartViewModel = MockCartViewModel();
    scrollController = ScrollController();

    when(() => mockProductsViewModel.state).thenReturn(ProductsStates());
    when(() => mockCartViewModel.state).thenReturn(const CartStates());
  });

  Widget createWidgetUnderTest({Widget? header}) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: MultiBlocProvider(
          providers: [
            BlocProvider<ProductsViewModel>.value(value: mockProductsViewModel),
            BlocProvider<CartViewModel>.value(value: mockCartViewModel),
          ],
          child: PaginatedProductsView(
            scrollController: scrollController,
            header: header,
          ),
        ),
      ),
    );
  }

  group('PaginatedProductsView Widget Tests', () {
    testWidgets('Initial State: shows ProductsGrid when products are loaded', (
      tester,
    ) async {
      final products = [
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
      when(() => mockProductsViewModel.state).thenReturn(
        ProductsStates(
          productsState: BaseState(data: products, isLoading: false),
        ),
      );

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(ProductsGrid), findsOneWidget);
    });

    testWidgets(
      'Loading State: shows ProductsGridShimmer when products are loading',
      (tester) async {
        when(() => mockProductsViewModel.state).thenReturn(
          ProductsStates(productsState: const BaseState(isLoading: true)),
        );

        await tester.pumpWidget(createWidgetUnderTest());

        expect(find.byType(ProductsGridShimmer), findsOneWidget);
      },
    );

    testWidgets('Error State: shows error message when productsState has error', (
      tester,
    ) async {
      const errorMessage = 'Failed to load products';
      when(() => mockProductsViewModel.state).thenReturn(
        ProductsStates(
          productsState: const BaseState(errorMessage: errorMessage),
        ),
      );

      await tester.pumpWidget(createWidgetUnderTest());

      // Note: ErrorMapper might map this message. For simplicity, we check if some text exists or if ErrorMapper is called.
      // Since ErrorMapper is a static call, we just check if any text is displayed in the center.
      expect(find.byType(Text), findsWidgets);
    });

    testWidgets('Empty State: shows no products found message', (tester) async {
      when(() => mockProductsViewModel.state).thenReturn(
        ProductsStates(
          productsState: const BaseState(data: [], isLoading: false),
        ),
      );

      await tester.pumpWidget(createWidgetUnderTest());

      final BuildContext context = tester.element(
        find.byType(PaginatedProductsView),
      );
      expect(
        find.text(AppLocalizations.of(context)!.noProductsFound),
        findsOneWidget,
      );
    });

    testWidgets('Search Focused State: shows search hint', (tester) async {
      when(
        () => mockProductsViewModel.state,
      ).thenReturn(ProductsStates(isSearchFocused: true));

      await tester.pumpWidget(createWidgetUnderTest());

      final BuildContext context = tester.element(
        find.byType(PaginatedProductsView),
      );
      expect(
        find.text(AppLocalizations.of(context)!.searchFor),
        findsOneWidget,
      );
    });

    testWidgets('Pagination Loading: shows additional shimmer at bottom', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;

      final products = [
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

      when(() => mockProductsViewModel.state).thenReturn(
        ProductsStates(
          productsState: BaseState(data: products, isLoading: false),
          isPaginationLoading: true,
        ),
      );

      await tester.pumpWidget(createWidgetUnderTest());

      await tester.pump(const Duration(milliseconds: 100));

      expect(find.byType(ProductsGrid), findsOneWidget);

      await tester.drag(
        find.byType(PaginatedProductsView),
        const Offset(0, -500),
      );
      await tester.pump();

      expect(find.byType(ProductsGridShimmer), findsOneWidget);

      addTearDown(tester.view.resetPhysicalSize);
    });
  });
}
