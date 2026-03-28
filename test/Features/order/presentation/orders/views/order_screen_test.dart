import 'package:flowers_app/Features/order/presentation/cart/view_model/cart_view_model.dart';
import 'package:flowers_app/Features/order/presentation/cart/view_model/cart_states.dart';
import 'package:flowers_app/Features/order/presentation/orders/view_model/orders_event.dart';
import 'package:flowers_app/Features/order/presentation/orders/view_model/orders_states.dart';
import 'package:flowers_app/Features/order/presentation/orders/view_model/orders_view_model.dart';
import 'package:flowers_app/Features/order/presentation/orders/views/order_screen.dart';
import 'package:flowers_app/Features/order/presentation/orders/widgets/order_tab_view.dart';
import 'package:flowers_app/Features/track_order/presentation/view_model/track_order_view_model.dart';
import 'package:flowers_app/Features/track_order/presentation/view_model/track_order_state.dart';
import 'package:flowers_app/core/base_states/base_states.dart';
import 'package:flowers_app/core/l10n/app_localizations.dart';
import 'package:flowers_app/core/l10n/view_model/language_cubit.dart';
 import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'order_screen_test.mocks.dart';


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

     when(mockOrdersViewModel.state).thenReturn(const OrdersState());
    when(mockOrdersViewModel.stream).thenAnswer((_) => const Stream.empty());

    when(mockLanguageCubit.state).thenReturn(const Locale('en'));
    when(mockLanguageCubit.stream).thenAnswer((_) => const Stream.empty());

    when(mockCartViewModel.state).thenReturn(const CartStates());

    when(mockTrackViewModel.state).thenReturn(TrackOrderStatusState(
        orderState: BaseState(isLoading: false)
    ));
    when(mockTrackViewModel.stream).thenAnswer((_) => const Stream.empty());
  });

  Widget createWidgetUnderTest() {
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
        child: const OrdersPage(),
      ),
    );
  }

  group('OrdersPage Widget Tests', () {
    testWidgets('should call GetUserOrdersEvent on initialization', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

       verify(mockOrdersViewModel.doIntent(any)).called(1);
    });

    testWidgets('should display AppBar title and TabBar with correct tabs', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

       final context = tester.element(find.byType(OrdersPage));
      final l10n = AppLocalizations.of(context)!;

      expect(find.text(l10n.myOrders), findsWidgets);
      expect(find.byType(TabBar), findsOneWidget);
      expect(find.text(l10n.active), findsOneWidget);
      expect(find.text(l10n.completed), findsOneWidget);
    });

    testWidgets('should send ChangeOrdersFilterEvent when switching tabs', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      final context = tester.element(find.byType(OrdersPage));
      final l10n = AppLocalizations.of(context)!;

       await tester.tap(find.text(l10n.completed));
      await tester.pumpAndSettle();

       verify(mockOrdersViewModel.doIntent(argThat(isA<ChangeOrdersFilterEvent>()))).called(1);
    });

    testWidgets('should show OrdersTabView in the body', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(TabBarView), findsOneWidget);
       expect(find.byType(OrdersTabView), findsAtLeastNWidgets(1));
    });
  });
}