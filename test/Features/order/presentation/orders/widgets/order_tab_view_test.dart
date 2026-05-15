import 'package:flowers_app/Features/commerce/domain/entities/product_entities/product_entity.dart';
import 'package:flowers_app/Features/order/domain/entities/cart/cart_item_entity.dart';
import 'package:flowers_app/Features/order/domain/entities/checkout/user_orders_entity.dart';
import 'package:flowers_app/Features/order/presentation/cart/view_model/cart_states.dart';
import 'package:flowers_app/Features/order/presentation/cart/view_model/cart_view_model.dart';
import 'package:flowers_app/Features/order/presentation/orders/view_model/orders_states.dart';
import 'package:flowers_app/Features/order/presentation/orders/view_model/orders_view_model.dart';
import 'package:flowers_app/Features/order/presentation/orders/widgets/order_card.dart';
import 'package:flowers_app/Features/order/presentation/orders/widgets/order_card_shimmer.dart';
import 'package:flowers_app/Features/order/presentation/orders/widgets/order_tab_view.dart';
import 'package:flowers_app/Features/track_order/presentation/view_model/track_order_state.dart';
import 'package:flowers_app/Features/track_order/presentation/view_model/track_order_view_model.dart';
import 'package:flowers_app/core/base_states/base_states.dart';
import 'package:flowers_app/core/l10n/app_localizations.dart';
import 'package:flowers_app/core/l10n/view_model/language_cubit.dart';
 import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// أضفنا OrderStatusViewModel للموك
import 'order_tab_view_test.mocks.dart';

@GenerateMocks([OrdersViewModel, CartViewModel, LanguageCubit, OrderStatusViewModel])
void main() {
  late MockOrdersViewModel mockOrdersViewModel;
  late MockCartViewModel mockCartViewModel;
  late MockLanguageCubit mockLanguageCubit;
  late MockOrderStatusViewModel mockTrackViewModel;

  setUp(() {
    mockOrdersViewModel = MockOrdersViewModel();
    mockCartViewModel = MockCartViewModel();
    mockLanguageCubit = MockLanguageCubit();
    mockTrackViewModel = MockOrderStatusViewModel();

    // إعداد حالة اللغة
    when(mockLanguageCubit.state).thenReturn(const Locale('en'));
    when(mockLanguageCubit.stream).thenAnswer((_) => const Stream.empty());

    // إعداد حالة السلة
    when(mockCartViewModel.state).thenReturn(const CartStates());

    // إعداد حالة تتبع الطلب (مهم جداً لتجنب Null Error)
    when(mockTrackViewModel.state).thenReturn(TrackOrderStatusState(
        orderState: BaseState(isLoading: false)
    ));
    when(mockTrackViewModel.stream).thenAnswer((_) => const Stream.empty());
  });

  final fakeProduct =   ProductEntity(
    id: "p1",
    title: "Red Rose",
    imgCover: "rose.jpg",
    slug: '',
    description: '',
    images: [],
    price: 0,
    priceAfterDiscount: 0,
    quantity: 0,
    categoryId: '',
    occasionId: '',
    sold: 0,
    rateAvg: 0,
    rateCount: 0,
    isInWishlist: false,
    discount: 0,
  );

  final fakeOrder = OrdersEntity(
    id: "order_1",
    orderNumber: "123",
    totalPrice: 500,
    orderItems: [CartItemEntity(product: fakeProduct, quantity: 2, price: 250)],
    updatedAt: "2026-02-05T14:30:00.000Z",
  );

  Widget createWidget({required OrdersTab tab}) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: MultiBlocProvider(
        providers: [
          BlocProvider<OrdersViewModel>.value(value: mockOrdersViewModel),
          BlocProvider<CartViewModel>.value(value: mockCartViewModel),
          BlocProvider<LanguageCubit>.value(value: mockLanguageCubit),
          BlocProvider<OrderStatusViewModel>.value(value: mockTrackViewModel),
        ],
        child: Scaffold(body: OrdersTabView(tab: tab)),
      ),
    );
  }

  group('OrdersTabView Widget Tests', () {
    testWidgets('shows OrderCardShimmer when isLoading is true', (tester) async {
      when(mockOrdersViewModel.state).thenReturn(const OrdersState(isLoading: true));
      when(mockOrdersViewModel.stream).thenAnswer((_) => Stream.value(const OrdersState(isLoading: true)));

      await tester.pumpWidget(createWidget(tab: OrdersTab.active));

      expect(find.byType(OrderCardShimmer), findsAtLeastNWidgets(1));
    });

    testWidgets('shows OrderCardShimmer when trackViewModel is loading', (tester) async {
      when(mockOrdersViewModel.state).thenReturn(const OrdersState(isLoading: false, activeOrders: []));
      when(mockOrdersViewModel.stream).thenAnswer((_) => Stream.value(const OrdersState(isLoading: false)));

      // محاكاة حالة التحميل في تتبع الطلب
      when(mockTrackViewModel.state).thenReturn(TrackOrderStatusState(
          orderState: BaseState(isLoading: true)
      ));

      await tester.pumpWidget(createWidget(tab: OrdersTab.active));

      expect(find.byType(OrderCardShimmer), findsAtLeastNWidgets(1));
    });

    testWidgets('shows Empty State message when no orders exist', (tester) async {
      when(mockOrdersViewModel.state).thenReturn(const OrdersState(activeOrders: []));
      when(mockOrdersViewModel.stream).thenAnswer((_) => Stream.value(const OrdersState(activeOrders: [])));

      await tester.pumpWidget(createWidget(tab: OrdersTab.active));
      await tester.pumpAndSettle();

      expect(find.byKey(const ValueKey('empty')), findsOneWidget);
    });

    testWidgets('displays list of OrderCards when orders are provided', (tester) async {
      final state = OrdersState(activeOrders: [fakeOrder]);
      when(mockOrdersViewModel.state).thenReturn(state);
      when(mockOrdersViewModel.stream).thenAnswer((_) => Stream.value(state));

      await tester.pumpWidget(createWidget(tab: OrdersTab.active));
      await tester.pump(); // لاستقرار الـ AnimatedSwitcher

      expect(find.byType(OrderCard), findsOneWidget);
      expect(find.textContaining('123'), findsOneWidget);
    });
  });
}