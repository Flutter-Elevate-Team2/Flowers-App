import 'package:bloc_test/bloc_test.dart';
import 'package:flowers_app/Features/commerce/domain/entities/product_entities/product_entity.dart';
import 'package:flowers_app/Features/commerce/presentation/home/widgets/product_details/product_details_bottom_bar.dart';
import 'package:flowers_app/Features/order/presentation/cart/view_model/cart_states.dart';
import 'package:flowers_app/Features/order/presentation/cart/view_model/cart_view_model.dart';
import 'package:flowers_app/Features/order/presentation/cart/widgets/shared/add_to_cart_button/cart_action_section.dart';
import 'package:flowers_app/core/l10n/app_localizations.dart';
import 'package:flowers_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCartViewModel extends MockBloc<CartStates, CartStates>
    implements CartViewModel {}

void main() {
  late ProductEntity testProduct;
  late MockCartViewModel mockCartViewModel;

  setUp(() {
    mockCartViewModel = MockCartViewModel();
    when(() => mockCartViewModel.state).thenReturn(CartStates());

    testProduct = ProductEntity(
      id: '1',
      title: 'Red Rose',
      description: 'Test description',
      price: 150,
      images: [],
      slug: '',
      imgCover: '',
      priceAfterDiscount: 0,
      quantity: 10,
      categoryId: '',
      occasionId: '',
      sold: 0,
      rateAvg: 0,
      rateCount: 0,
      isInWishlist: false,
      discount: 0,
    );
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: BlocProvider<CartViewModel>.value(
          value: mockCartViewModel,
          child: ProductDetailsBottomBar(product: testProduct),
        ),
      ),
    );
  }

  group('ProductDetailsBottomBar Tests', () {
    testWidgets('renders CartActionSection with correct product', (
      tester,
    ) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      expect(find.byType(CartActionSection), findsOneWidget);

      final cartActionWidget = tester.widget<CartActionSection>(
        find.byType(CartActionSection),
      );
      expect(cartActionWidget.product.id, testProduct.id);
    });

    testWidgets('has correct styling (shadow and background)', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      final containerFinder = find
          .ancestor(
            of: find.byType(CartActionSection),
            matching: find.byType(Container),
          )
          .first;

      final container = tester.widget<Container>(containerFinder);
      final decoration = container.decoration as BoxDecoration;

      expect(decoration.boxShadow, isNotNull);
      expect(decoration.color, AppColors.white);
    });
  });
}
