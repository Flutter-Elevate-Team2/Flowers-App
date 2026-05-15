import 'package:flowers_app/Features/commerce/domain/entities/product_entities/product_entity.dart';
import 'package:flowers_app/Features/order/domain/entities/cart/cart_entity.dart';
import 'package:flowers_app/Features/order/domain/entities/cart/cart_item_entity.dart';
 import 'package:flowers_app/Features/order/presentation/cart/view_model/cart_states.dart';
import 'package:flowers_app/Features/order/presentation/cart/view_model/cart_view_model.dart';
import 'package:flowers_app/Features/order/presentation/cart/widgets/cart_body.dart';
import 'package:flowers_app/Features/order/presentation/cart/widgets/cart_product_card/cart_product_card.dart';
import 'package:flowers_app/core/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flowers_app/core/l10n/app_localizations.dart';

 @GenerateMocks([CartViewModel, GoRouter])
import 'cart_body_test.mocks.dart';

void main() {
  late MockCartViewModel mockCartViewModel;
  late MockGoRouter mockGoRouter;

  setUp(() {
    mockCartViewModel = MockCartViewModel();
    mockGoRouter = MockGoRouter();

    // 1. حل مشكلة الـ MissingStubError للـ Bloc/Cubit
    when(mockCartViewModel.stream).thenAnswer((_) => const Stream.empty());
    when(mockCartViewModel.state).thenReturn(CartStates());

    // 2. حل مشكلة الـ MissingStubError للـ GoRouter (pushNamed)
    // نستخدم anyNamed للتعامل مع الباراميترز الاختيارية في GoRouter
    when(mockGoRouter.pushNamed(
      any,
      pathParameters: anyNamed('pathParameters'),
      queryParameters: anyNamed('queryParameters'),
      extra: anyNamed('extra'),
    )).thenAnswer((_) async => null);
  });

  // دالة مساعدة لبناء الـ Widget مع كل الـ Providers والـ Localizations اللازمة
  Widget createWidgetUnderTest(CartEntity? cart) {
    return BlocProvider<CartViewModel>.value(
      value: mockCartViewModel,
      child: MaterialApp(
        // ربط الـ GoRouter الوهمي بالـ Context
        builder: (context, child) => InheritedGoRouter(
          goRouter: mockGoRouter,
          child: child!,
        ),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('en'), Locale('ar')],
        home: Scaffold(
          body: CartBody(cart: cart, locale: 'en'),
        ),
      ),
    );
  }

  // إنشاء منتج وهمي لتقليل تكرار الكود
  ProductEntity createMockProduct(String id, String title) {
    return ProductEntity(
      id: id, title: title, slug: '', description: '', imgCover: '',
      images: [], price: 100, priceAfterDiscount: 90, quantity: 1,
      categoryId: 'cat1', occasionId: 'occ1', sold: 10, rateAvg: 4,
      rateCount: 20, isInWishlist: false, discount: 10,
    );
  }

  group('CartBody Widget Tests', () {

    testWidgets('Should display correct number of cart items', (tester) async {
      // Arrange
      final mockCart = CartEntity(
        cartItems: [
          CartItemEntity(product: createMockProduct('1', 'Rose Bouquet')),
          CartItemEntity(product: createMockProduct('2', 'Tulips')),
        ],
        totalPrice: 180,
        deliveryFee: 20,
       );

      // Act
      await tester.pumpWidget(createWidgetUnderTest(mockCart));
      // نستخدم pump مع وقت محدد بدلاً من pumpAndSettle لتجنب الـ timeout بسبب الصور
      await tester.pump(const Duration(milliseconds: 500));

      // Assert
      expect(find.byType(CartProductCard), findsNWidgets(2));
      expect(find.text('Rose Bouquet'), findsOneWidget);
      expect(find.byType(CustomButton), findsOneWidget);
    });

     testWidgets('Should navigate to checkout when checkout button is pressed', (tester) async {
      // Arrange
      final mockCart = CartEntity(cartItems: [], totalPrice: 0,);
      await tester.pumpWidget(createWidgetUnderTest(mockCart));

      // Act
      await tester.tap(find.byType(CustomButton));
      await tester.pump();

      // Assert: التحقق من استدعاء الـ Router للذهاب لصفحة الـ Checkout
      verify(mockGoRouter.pushNamed(any)).called(1);
    });
  });
}