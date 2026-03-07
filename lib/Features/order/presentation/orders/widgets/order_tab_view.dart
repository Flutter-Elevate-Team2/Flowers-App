// ignore_for_file: use_build_context_synchronously

import 'package:flowers_app/Features/order/data/models/cart/cart_request_dto.dart';
import 'package:flowers_app/Features/order/domain/entities/checkout/user_orders_entity.dart';
import 'package:flowers_app/Features/order/presentation/cart/view_model/cart_events.dart';
import 'package:flowers_app/Features/order/presentation/cart/view_model/cart_view_model.dart';
import 'package:flowers_app/Features/order/presentation/orders/view_model/orders_states.dart';
import 'package:flowers_app/Features/order/presentation/orders/view_model/orders_view_model.dart';
import 'package:flowers_app/Features/order/presentation/orders/widgets/order_card_shimmer.dart';
import 'package:flowers_app/Features/track_order/domain/entities/order_status.dart';
import 'package:flowers_app/Features/track_order/presentation/view_model/track_order_event.dart';
import 'package:flowers_app/Features/track_order/presentation/view_model/track_order_view_model.dart';
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
    final trackViewModel = context.read<OrderStatusViewModel>();

    return BlocBuilder<OrdersViewModel, OrdersState>(
      builder: (context, state) {
        final orders = tab == OrdersTab.active
            ? state.activeOrders
            : state.completedOrders;

        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          child: _buildBody(context, state, orders, trackViewModel),
        );
      },
    );
  }

  Widget _buildBody(
    BuildContext context,
    OrdersState state,
    List<OrdersEntity> orders,
    OrderStatusViewModel trackViewModel,
  ) {
    if (state.isLoading ||
        (state.isFiltering && orders.isEmpty ||
            trackViewModel.state.orderState!.isLoading)) {
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
        final isCancelled = orders[index].state == "canceled";


            return OrderCard(
              order: orders[index],
              isCompleted: tab == OrdersTab.completed,
              onButtonPressed: () => _handleOrderAction(
                context,
                orders[index],
                 isCancelled,
              ),
              locale: locale,
            );
      },
    );
  }

  Future<void> _handleOrderAction(
    BuildContext context,
    dynamic order,
     bool isCancelled,
  ) async {
    final trackViewModel = context.read<OrderStatusViewModel>();
     trackViewModel.doIntent(
      context,
      FetchOrderDetailsEvent(order.id ?? ''),
    );
    await Future.delayed(const Duration(milliseconds: 300));

    final orderState =
        trackViewModel.state.orderState?.data?.status ?? '';

    bool isAccepted = orderState == OrderStatus.accepted.firebaseValue;
    bool isReceived = orderState == OrderStatus.receivedYourOrder.firebaseValue;
    bool isPreparing = orderState == OrderStatus.preparingYourOrder.firebaseValue;
    bool isArrived = orderState == OrderStatus.outForDelivery.firebaseValue;
    bool isDelivered = orderState == OrderStatus.delivered.firebaseValue;

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
      /// Track Order
      (isCancelled)
          ? context.pushNamed(
              Routes.cancelledOrderName,
              pathParameters: {'orderId': order.id ?? ''},
            )
          : (isAccepted ||
                isReceived ||
                isPreparing ||
                isArrived ||
                isDelivered)
          ? context.pushNamed(
              Routes.trackOrderName,
              pathParameters: {'orderId': order.id ?? ''},
            )
          : context.pushNamed(
              Routes.placedSuccessfullyName,
              pathParameters: {'orderId': order.id ?? ''},
            );
    }
  }
}
