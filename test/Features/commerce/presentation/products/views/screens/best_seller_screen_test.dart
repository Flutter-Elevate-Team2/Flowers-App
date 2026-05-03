import 'package:bloc_test/bloc_test.dart';
import 'package:flowers_app/Features/commerce/domain/entities/product_entities/best_seller_entity.dart';
import 'package:flowers_app/Features/commerce/presentation/products/views/screens/best_seller_screen.dart';
import 'package:flowers_app/Features/commerce/presentation/products/widgets/shared/product_card/product_card.dart';
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
  late List<BestSellerEntity> testBestSellers;

  setUp(() {
    mockCartViewModel = MockCartViewModel();
    testBestSellers = [
      BestSellerEntity(
        id: '1',
        name: 'Best Product 1',
        description: 'Description 1',
        imageUrl: 'url1',
        images: [],
        price: 100,
        priceAfterDiscount: 80,
        quantity: 10,
        discount: 20,
      ),
      BestSellerEntity(
        id: '2',
        name: 'Best Product 2',
        description: 'Description 2',
        imageUrl: 'url2',
        images: [],
        price: 200,
        priceAfterDiscount: 150,
        quantity: 5,
        discount: 50,
      ),
    ];

    when(() => mockCartViewModel.state).thenReturn(const CartStates());
  });

  Widget createWidgetUnderTest(Widget child) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: MultiBlocProvider(
        providers: [
          BlocProvider<CartViewModel>.value(value: mockCartViewModel),
        ],
        child: child,
      ),
    );
  }

  group('BestSeller Widget Tests', () {
    testWidgets('renders correctly with list of best sellers', (tester) async {
      await tester.pumpWidget(
        createWidgetUnderTest(BestSeller(bestSellers: testBestSellers)),
      );

      expect(find.text('Best Product 1'), findsOneWidget);
      expect(find.text('Best Product 2'), findsOneWidget);
      expect(find.byType(ProductCard), findsNWidgets(2));
    });

    testWidgets('renders empty state when bestSellers is null', (tester) async {
      await tester.pumpWidget(
        createWidgetUnderTest(const BestSeller(bestSellers: null)),
      );

      expect(find.byType(ProductCard), findsNothing);
    });

    testWidgets('renders empty state when bestSellers list is empty', (
      tester,
    ) async {
      await tester.pumpWidget(
        createWidgetUnderTest(const BestSeller(bestSellers: [])),
      );

      expect(find.byType(ProductCard), findsNothing);
    });

    group('Responsive Grid Tests', () {
      testWidgets('GridView should have 2 columns', (tester) async {
        await tester.pumpWidget(
          createWidgetUnderTest(BestSeller(bestSellers: testBestSellers)),
        );

        final gridViewFinder = find.byType(GridView);
        final GridView gridView = tester.widget(gridViewFinder);
        final delegate =
            gridView.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount;

        expect(delegate.crossAxisCount, equals(2));
      });
    });
  });
}
