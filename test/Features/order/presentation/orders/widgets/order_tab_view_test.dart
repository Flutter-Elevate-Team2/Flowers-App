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
import 'package:flowers_app/core/l10n/app_localizations.dart';
import 'package:flowers_app/core/l10n/view_model/language_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'order_tab_view_test.mocks.dart';

@GenerateMocks([OrdersViewModel, CartViewModel, LanguageCubit])
void main() {
  late MockOrdersViewModel mockOrdersViewModel;
  late MockCartViewModel mockCartViewModel;
  late MockLanguageCubit mockLanguageCubit;

  setUp(() {
    mockOrdersViewModel = MockOrdersViewModel();
    mockCartViewModel = MockCartViewModel();
    mockLanguageCubit = MockLanguageCubit();

    when(mockLanguageCubit.state).thenReturn(const Locale('en'));
    when(mockLanguageCubit.stream).thenAnswer((_) => const Stream.empty());
    when(mockCartViewModel.state).thenReturn(const CartStates());
  });
  final fakeProduct = ProductEntity(
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
        ],
        child: OrdersTabView(tab: tab),
      ),
    );
  }

  group('OrdersTabView Widget Tests', () {
    testWidgets('shows OrderCardShimmer when isLoading is true', (
      tester,
    ) async {
      when(
        mockOrdersViewModel.state,
      ).thenReturn(const OrdersState(isLoading: true));
      when(
        mockOrdersViewModel.stream,
      ).thenAnswer((_) => Stream.value(const OrdersState(isLoading: true)));

      await tester.pumpWidget(createWidget(tab: OrdersTab.active));

      expect(find.byType(OrderCardShimmer), findsAtLeastNWidgets(1));
    });

    testWidgets(
      'shows OrderCardShimmer when isFiltering is true and orders are empty',
      (tester) async {
        when(
          mockOrdersViewModel.state,
        ).thenReturn(const OrdersState(isFiltering: true, activeOrders: []));
        when(mockOrdersViewModel.stream).thenAnswer(
          (_) => Stream.value(
            const OrdersState(isFiltering: true, activeOrders: []),
          ),
        );

        await tester.pumpWidget(createWidget(tab: OrdersTab.active));

        expect(find.byType(OrderCardShimmer), findsAtLeastNWidgets(1));
      },
    );

    testWidgets('shows Empty State message when no orders exist', (
      tester,
    ) async {
      when(
        mockOrdersViewModel.state,
      ).thenReturn(const OrdersState(activeOrders: []));
      when(
        mockOrdersViewModel.stream,
      ).thenAnswer((_) => Stream.value(const OrdersState(activeOrders: [])));

      await tester.pumpWidget(createWidget(tab: OrdersTab.active));

      expect(find.byKey(const ValueKey('empty')), findsOneWidget);
    });

    testWidgets('displays list of OrderCards when orders are provided', (
      tester,
    ) async {
      when(
        mockOrdersViewModel.state,
      ).thenReturn(OrdersState(activeOrders: [fakeOrder]));
      when(
        mockOrdersViewModel.stream,
      ).thenAnswer((_) => Stream.value(OrdersState(activeOrders: [fakeOrder])));

      await tester.pumpWidget(createWidget(tab: OrdersTab.active));

      expect(find.byType(OrderCard), findsOneWidget);
      expect(find.textContaining('123'), findsOneWidget);
    });
  });
}
