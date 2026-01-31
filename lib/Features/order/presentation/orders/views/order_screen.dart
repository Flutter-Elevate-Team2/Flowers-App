import 'package:flowers_app/Features/order/presentation/orders/view_model/orders_event.dart';
import 'package:flowers_app/Features/order/presentation/orders/view_model/orders_view_model.dart';
import 'package:flowers_app/Features/order/presentation/orders/widgets/order_tab_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);

    final viewModel = context.read<OrdersViewModel>();

    viewModel.doIntent(GetUserOrdersEvent());

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) return;

      if (_tabController.index == 0) {
        viewModel.doIntent(
          ChangeOrdersFilterEvent(OrderFilter.pending),
        );
      } else {
        viewModel.doIntent(
          ChangeOrdersFilterEvent(OrderFilter.completed),
        );
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My orders'
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: const Color(0xffD11B67),
          labelColor: const Color(0xffD11B67),
          unselectedLabelColor: Colors.grey,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold),
          indicatorWeight: 3,
          tabs: const [
            Tab(text: 'Active'),
            Tab(text: 'Completed'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          OrdersTabView(tab: OrdersTab.active),
          OrdersTabView(tab: OrdersTab.completed),
        ],
      ),
    );
  }
}
