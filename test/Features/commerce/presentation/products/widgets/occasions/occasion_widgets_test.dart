import 'package:bloc_test/bloc_test.dart';
import 'package:flowers_app/Features/commerce/domain/entities/home_entities/occasion_entity.dart';
import 'package:flowers_app/Features/commerce/presentation/products/view_model/products_events.dart';
import 'package:flowers_app/Features/commerce/presentation/products/view_model/products_states.dart';
import 'package:flowers_app/Features/commerce/presentation/products/view_model/products_view_model.dart';
import 'package:flowers_app/Features/commerce/presentation/products/widgets/occasions/occasion_body.dart';
import 'package:flowers_app/Features/commerce/presentation/products/widgets/occasions/occasion_page.dart';
import 'package:flowers_app/Features/commerce/presentation/products/widgets/shared/default_tab_bar.dart';
import 'package:flowers_app/Features/commerce/presentation/products/widgets/shared/paginated_products_view.dart';
import 'package:flowers_app/Features/order/presentation/cart/view_model/cart_states.dart';
import 'package:flowers_app/Features/order/presentation/cart/view_model/cart_view_model.dart';
import 'package:flowers_app/core/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockProductsViewModel extends MockCubit<ProductsStates> implements ProductsViewModel {}
class MockCartViewModel extends MockCubit<CartStates> implements CartViewModel {}

void main() {
  late MockProductsViewModel mockProductsViewModel;
  late MockCartViewModel mockCartViewModel;
  late List<OccasionEntity> testOccasions;

  setUp(() {
    mockProductsViewModel = MockProductsViewModel();
    mockCartViewModel = MockCartViewModel();
    testOccasions = [
      OccasionEntity(id: '1', name: 'Birthday', imageUrl: 'img1'),
      OccasionEntity(id: '2', name: 'Wedding', imageUrl: 'img2'),
    ];

    when(() => mockProductsViewModel.state).thenReturn(ProductsStates());
    when(() => mockCartViewModel.state).thenReturn(const CartStates());
    registerFallbackValue(LoadMoreProductsEvent());
    registerFallbackValue(FetchProductsEvent());
  });

  Widget createWidgetUnderTest(Widget child) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: MultiBlocProvider(
          providers: [
            BlocProvider<ProductsViewModel>.value(value: mockProductsViewModel),
            BlocProvider<CartViewModel>.value(value: mockCartViewModel),
          ],
          child: child,
        ),
      ),
    );
  }

  group('OccasionPage Widget Tests', () {
    testWidgets('Initial State: renders correctly with tabs', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest(OccasionPage(
        occasions: testOccasions,
        initialIndex: 0,
      )));
      expect(find.byType(OccasionBody), findsOneWidget);
      expect(find.text('Birthday'), findsWidgets);
    });

    // testWidgets('Interaction: triggers LoadMoreProductsEvent on scroll', (tester) async {
    //   final manyProducts = List.generate(
    //     10,
    //         (index) => ProductEntity(
    //       id: '$index', title: 'P$index', slug: 's', description: 'd',
    //       imgCover: 'i', images: [], price: 10, priceAfterDiscount: 8,
    //       quantity: 5, categoryId: 'c', occasionId: 'o', sold: 0,
    //       rateAvg: 0, rateCount: 0, isInWishlist: false, discount: 0,
    //     ),
    //   );
    //
    //   when(() => mockProductsViewModel.state).thenReturn(
    //     ProductsStates(
    //       productsState:BaseState(data: manyProducts),
    //       nextPage: 2,
    //     ),
    //   );
    //
    //   tester.view.physicalSize = const Size(400, 500);
    //   addTearDown(tester.view.resetPhysicalSize);
    //
    //   await tester.pumpWidget(createWidgetUnderTest(OccasionPage(
    //     occasions: testOccasions,
    //     initialIndex: 0,
    //   )));
    //
    //   await tester.drag(find.byType(CustomScrollView), const Offset(0, -3000));
    //   await tester.pump();
    //
    //   verify(() => mockProductsViewModel.doIntent(any(that: isA<LoadMoreProductsEvent>()))).called(greaterThanOrEqualTo(1));
    // });
  });

  group('OccasionBody Widget Tests', () {
    testWidgets('Initial State: renders PaginatedProductsView and DefaultTabBar', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest(
        DefaultTabController(
          length: 1,
          child: OccasionBody(
            tabs: const ['Tab 1'],
            scrollController: ScrollController(),
            occasions: testOccasions,
          ),
        ),
      ));
      expect(find.byType(PaginatedProductsView), findsOneWidget);
      expect(find.byType(DefaultTabBar), findsOneWidget);
    });

    testWidgets('Interaction: triggers FetchProductsEvent when tab is tapped', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest(
        DefaultTabController(
          length: 2,
          child: OccasionBody(
            tabs: const ['Birthday', 'Wedding'],
            scrollController: ScrollController(),
            occasions: testOccasions,
          ),
        ),
      ));
      await tester.tap(find.text('Wedding').first);
      await tester.pumpAndSettle();
      verify(() => mockProductsViewModel.doIntent(any(that: isA<FetchProductsEvent>()))).called(1);
    });
  });
}