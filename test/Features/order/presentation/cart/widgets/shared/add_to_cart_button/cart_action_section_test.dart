import 'package:flowers_app/Features/commerce/domain/entities/product_entities/product_entity.dart';
import 'package:flowers_app/Features/order/presentation/cart/view_model/cart_events.dart';
import 'package:flowers_app/Features/order/presentation/cart/view_model/cart_states.dart';
import 'package:flowers_app/Features/order/presentation/cart/view_model/cart_view_model.dart';
import 'package:flowers_app/Features/order/presentation/cart/widgets/shared/add_to_cart_button/cart_action_section.dart';
 import 'package:flowers_app/Features/order/presentation/cart/widgets/shared/cart_action_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

 @GenerateMocks([CartViewModel, CartActionStyle])
import 'cart_action_section_test.mocks.dart';

void main() {
  late MockCartViewModel mockViewModel;
  late MockCartActionStyle mockStyle;

  setUp(() {
    mockViewModel = MockCartViewModel();
    mockStyle = MockCartActionStyle();

     when(mockViewModel.stream).thenAnswer((_) => const Stream.empty());
    when(mockViewModel.state).thenReturn(CartStates());
  });

   Widget createWidgetUnderTest(ProductEntity product) {
    return MaterialApp(
      home: Scaffold(
        body: BlocProvider<CartViewModel>.value(
          value: mockViewModel,
          child: CartActionSection(
            product: product,
            style: mockStyle,
          ),
        ),
      ),
    );
  }

  ProductEntity createTestProduct({required String id, int quantity = 10}) {
    return ProductEntity(
      id: id,
      title: 'Test Flower',
      quantity: quantity,
      // أضف بقية الباراميترز المطلوبة في الـ Entity الخاص بك
      slug: '', description: '', imgCover: '', images: [], price: 10,
      priceAfterDiscount: 10, categoryId: '', occasionId: '',
      sold: 0, rateAvg: 0, rateCount: 0, isInWishlist: false, discount: 0,
    );
  }

  group('CartActionSection Tests', () {
    testWidgets('يجب عرض زر "Sold Out" عندما تكون كمية المنتج 0', (tester) async {
      final product = createTestProduct(id: '1', quantity: 0);

      when(mockStyle.buildSoldOut(any)).thenReturn(const Text('Sold Out View'));

      await tester.pumpWidget(createWidgetUnderTest(product));

      expect(find.text('Sold Out View'), findsOneWidget);
      verify(mockStyle.buildSoldOut(any)).called(1);
    });

    testWidgets('يجب عرض "Add Button" عندما تكون الكمية في العربة 0', (tester) async {
      final product = createTestProduct(id: '1');

      // إعداد الحالة لتكون الكمية الحالية 0
      when(mockViewModel.state).thenReturn(CartStates(
        // تأكد من أن getDisplayedQuantity ستعيد 0
      ));

      when(mockStyle.buildAddButton(any,
          key: anyNamed('key'),
          isLoading: anyNamed('isLoading'),
          onAdd: anyNamed('onAdd')))
          .thenReturn(const Text('Add to Cart'));

      await tester.pumpWidget(createWidgetUnderTest(product));

      expect(find.text('Add to Cart'), findsOneWidget);
    });

    testWidgets('يجب إرسال AddToCartEvent عند النقر على زر الإضافة', (tester) async {
      final product = createTestProduct(id: '123');

      // سنحتاج لالتقاط الـ callback الذي يتم تمريره للـ style
      VoidCallback? capturedOnAdd;

      when(mockStyle.buildAddButton(any,
          key: anyNamed('key'),
          isLoading: false,
          onAdd: anyNamed('onAdd')))
          .thenAnswer((invocation) {
        capturedOnAdd = invocation.namedArguments[#onAdd];
        return const SizedBox();
      });

      await tester.pumpWidget(createWidgetUnderTest(product));

      // محاكاة النقر من خلال استدعاء الـ callback الممرر للـ style
      capturedOnAdd?.call();

      verify(mockViewModel.doIntent(argThat(isA<AddToCartEvent>()))).called(1);
    });

   });
}