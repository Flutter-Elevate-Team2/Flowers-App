import 'package:bloc_test/bloc_test.dart';
import 'package:flowers_app/Features/commerce/domain/entities/product_entities/product_entity.dart';
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
  late ProductEntity testProduct;

  setUp(() {
    mockCartViewModel = MockCartViewModel();
    testProduct = ProductEntity(
      id: '1',
      title: 'Test Product',
      slug: 'test-product',
      description: 'Description',
      imgCover: 'https://example.com/image.jpg',
      images: [],
      price: 100,
      priceAfterDiscount: 80,
      quantity: 10,
      categoryId: 'cat1',
      occasionId: 'occ1',
      sold: 5,
      rateAvg: 4,
      rateCount: 10,
      isInWishlist: false,
      discount: 20,
    );

    when(() => mockCartViewModel.state).thenReturn(const CartStates());
  });

  Widget createWidgetUnderTest({
    required ProductEntity product,
    VoidCallback? onTap,
  }) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: BlocProvider<CartViewModel>.value(
          value: mockCartViewModel,
          child: ProductCard(product: product, onTap: onTap),
        ),
      ),
    );
  }

  group('ProductCard Widget Tests', () {
    testWidgets('Interaction: triggers onTap when clicked', (tester) async {
      bool tapped = false;
      await tester.pumpWidget(
        createWidgetUnderTest(product: testProduct, onTap: () => tapped = true),
      );

      final inkWellFinder = find
          .descendant(
            of: find.byType(ProductCard),
            matching: find.byType(InkWell),
          )
          .first;

      await tester.tap(inkWellFinder);
      await tester.pump();

      expect(tapped, isTrue);
    });

    testWidgets(
      'Loading State: AbsorbPointer is active when product is updating',
      (tester) async {
        when(
          () => mockCartViewModel.state,
        ).thenReturn(CartStates(updatingItemIds: {testProduct.id}));

        await tester.pumpWidget(createWidgetUnderTest(product: testProduct));

        final absorbPointers = tester.widgetList<AbsorbPointer>(
          find.byType(AbsorbPointer),
        );

        final isAnyAbsorbing = absorbPointers.any(
          (widget) => widget.absorbing == true,
        );

        expect(isAnyAbsorbing, isTrue);
      },
    );

    testWidgets('Initial State: AbsorbPointer is not active when not loading', (
      tester,
    ) async {
      await tester.pumpWidget(createWidgetUnderTest(product: testProduct));

      final productCardContent = find.text(testProduct.title);
      final mainAbsorbPointer = find
          .ancestor(
            of: productCardContent,
            matching: find.byType(AbsorbPointer),
          )
          .first;

      final AbsorbPointer absorbPointer = tester.widget(mainAbsorbPointer);
      expect(absorbPointer.absorbing, isFalse);
    });
  });
}
