import 'package:flowers_app/Features/order/data/models/cart/cart_request_dto.dart';
import 'package:flowers_app/Features/order/domain/entities/checkout/user_orders_entity.dart';
import 'package:flowers_app/Features/order/presentation/cart/view_model/cart_events.dart';
import 'package:flowers_app/Features/order/presentation/cart/view_model/cart_view_model.dart';
import 'package:flowers_app/Features/order/presentation/orders/view_model/orders_states.dart';
import 'package:flowers_app/Features/order/presentation/orders/view_model/orders_view_model.dart';
import 'package:flowers_app/Features/order/presentation/orders/widgets/order_card_shimmer.dart';
import 'package:flowers_app/core/app_router/app_router.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flowers_app/core/l10n/view_model/language_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'order_card.dart';

enum OrdersTab { active, completed }

class OrdersTabView extends StatelessWidget {
  final OrdersTab tab;

  const OrdersTabView({required this.tab, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersViewModel, OrdersState>(
      builder: (context, state) {
        final orders = tab == OrdersTab.active
            ? state.activeOrders
            : state.completedOrders;

        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          child: _buildBody(context, state, orders),
        );
      },
    );
  }

  Widget _buildBody(
    BuildContext context,
    OrdersState state,
    List<OrdersEntity> orders,
  ) {
    if (state.isLoading || (state.isFiltering && orders.isEmpty)) {
      return ListView.builder(
        key: ValueKey('loading_${tab.name}'),
        itemCount: 5,
        itemBuilder: (_, __) => const OrderCardShimmer(),
      );
    }

    if (orders.isEmpty) {
      return Center(
        key: ValueKey('empty'),
        child: Text(context.l10n.noOrdersFound),
      );
    }

    return ListView.builder(
      key: ValueKey('list_${tab.name}'),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final locale = context.read<LanguageCubit>().state.languageCode;

        return OrderCard(
          order: orders[index],
          isCompleted: tab == OrdersTab.completed,
          onButtonPressed: () => _handleOrderAction(context, orders[index]),
          locale: locale,
        );
      },
    );
  }

  Future<void> _handleOrderAction(BuildContext context, dynamic order) async {
    if (tab == OrdersTab.completed) {
      final cartViewModel = context.read<CartViewModel>();

      await cartViewModel.doIntent(ClearCartEvent());

      for (var item in order.orderItems ?? []) {
        cartViewModel.doIntent(
          AddToCartEvent(
            CartRequest(
              product: item.product?.id ?? '',
              quantity: item.quantity ?? 1,
            ),
          ),
        );
      }

      await Future.delayed(const Duration(milliseconds: 300));
      if (context.mounted) {
        context.goNamed(Routes.cartName);
      }
    } else {
      context.goNamed(Routes.trackOrderName);
    }
  }
}
