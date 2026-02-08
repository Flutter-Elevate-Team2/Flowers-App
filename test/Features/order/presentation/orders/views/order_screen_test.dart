import 'package:flowers_app/Features/order/domain/use_cases/get_user_orders.dart';
import 'package:flowers_app/Features/order/presentation/orders/view_model/orders_event.dart';
import 'package:flowers_app/Features/order/presentation/orders/view_model/orders_states.dart';
import 'package:flowers_app/Features/order/presentation/orders/view_model/orders_view_model.dart';
import 'package:flowers_app/Features/order/presentation/orders/views/order_screen.dart';
import 'package:flowers_app/Features/order/presentation/orders/widgets/order_tab_view.dart';
import 'package:flowers_app/core/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../widgets/order_tab_view_test.mocks.dart';

@GenerateMocks([OrdersViewModel])
void main() {
  late MockOrdersViewModel mockOrdersViewModel;

  Widget createWidgetUnderTest() {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: BlocProvider<OrdersViewModel>.value(
        value: mockOrdersViewModel,
        child: const OrdersPage(),
      ),
    );
  }

  setUp(() {
    mockOrdersViewModel = MockOrdersViewModel();
    when(mockOrdersViewModel.state).thenReturn(const OrdersState());
    when(mockOrdersViewModel.stream).thenAnswer((_) => const Stream.empty());
  });

  group('OrdersPage Widget Tests', () {
    testWidgets('should call GetUserOrdersEvent on initialization', (
      tester,
    ) async {
      await tester.pumpWidget(createWidgetUnderTest());

      verify(
        mockOrdersViewModel.doIntent(argThat(isA<GetUserOrdersEvent>())),
      ).called(1);
    });

    testWidgets('should display AppBar title and TabBar with correct tabs', (
      tester,
    ) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.textContaining('My orders'), findsWidgets);
      expect(find.byType(TabBar), findsOneWidget);
      expect(find.text('Active'), findsOneWidget);
      expect(find.text('Completed'), findsOneWidget);
    });

    testWidgets('should send ChangeOrdersFilterEvent when switching tabs', (
      tester,
    ) async {
      await tester.pumpWidget(createWidgetUnderTest());

      await tester.tap(find.text('Completed'));

      await tester.pumpAndSettle();

      verify(
        mockOrdersViewModel.doIntent(
          argThat(
            isA<ChangeOrdersFilterEvent>().having(
              (e) => e.filter,
              'filter',
              OrderFilter.completed,
            ),
          ),
        ),
      ).called(1);
    });

    testWidgets('should show OrdersTabView in the body', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(TabBarView), findsOneWidget);
      expect(find.byType(OrdersTabView), findsOneWidget);
    });
  });
}
