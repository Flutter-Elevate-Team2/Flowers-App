import 'package:flowers_app/Features/order/presentation/orders/view_model/orders_states.dart';
import 'package:flowers_app/Features/order/presentation/orders/view_model/orders_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'order_card.dart';

enum OrdersTab { active, completed }

class OrdersTabView extends StatelessWidget {
  final OrdersTab tab;

  const OrdersTabView({required this.tab, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersViewModel, OrdersState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.errorMessage != null) {
          return Center(child: Text(state.errorMessage!));
        }

        final orders = tab == OrdersTab.active
            ? state.filteredOrders
            .where((o) => o.state == 'pending' || o.isPaid == false)
            .toList()
            : state.filteredOrders
            .where((o) => o.state == 'completed' )
            .toList();

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
              onButtonPressed: () {
                if (tab == OrdersTab.active) {
                  // هنا ممكن تحطي navigation للـ tracking page
                } else {
                  // هنا ممكن تحطي reorder function
                }
              },
            );
          },
        );
      },
    );
  }
}
