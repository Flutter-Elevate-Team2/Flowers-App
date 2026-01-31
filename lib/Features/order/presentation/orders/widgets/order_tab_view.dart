import 'package:flowers_app/Features/order/data/models/cart/cart_request_dto.dart';
import 'package:flowers_app/Features/order/presentation/cart/view_model/cart_events.dart';
import 'package:flowers_app/Features/order/presentation/cart/view_model/cart_view_model.dart';
import 'package:flowers_app/Features/order/presentation/orders/view_model/orders_states.dart';
import 'package:flowers_app/Features/order/presentation/orders/view_model/orders_view_model.dart';
import 'package:flowers_app/Features/order/presentation/orders/widgets/order_card_shimmer.dart';
import 'package:flowers_app/core/app_router/app_router.dart';
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
        // API loading
        if (state.isLoading) {
          return ListView.builder(
            itemCount: 4,
            itemBuilder: (_, __) => const OrderCardShimmer(),
          );
        }

        // Tab shimmer
        if (state.isFiltering) {
          return ListView.builder(
            itemCount: 4,
            itemBuilder: (_, __) => const OrderCardShimmer(),
          );
        }

        if (state.errorMessage != null) {
          return Center(child: Text(state.errorMessage!));
        }

        final orders = state.filteredOrders;

        if (orders.isEmpty) {
          return const Center(child: Text('No orders found'));
        }

        return ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) {
            final order = orders[index];
            return OrderCard(
              order: order,
              isCompleted: tab == OrdersTab.completed,
              onButtonPressed: () async {
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

                  await Future.delayed(const Duration(milliseconds: 500));

                  context.goNamed(Routes.cartName);

                } else {
                  // Track order logic
                }
              },
            );
          },
        );
      },
    );
  }

}
