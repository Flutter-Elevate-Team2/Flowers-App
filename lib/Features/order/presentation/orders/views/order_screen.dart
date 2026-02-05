import 'package:flowers_app/Features/order/domain/use_cases/get_user_orders.dart';
import 'package:flowers_app/Features/order/presentation/orders/view_model/orders_event.dart';
import 'package:flowers_app/Features/order/presentation/orders/view_model/orders_view_model.dart';
import 'package:flowers_app/Features/order/presentation/orders/widgets/order_tab_view.dart';
import 'package:flowers_app/Features/order/presentation/orders/widgets/tab_indicator.dart';
import 'package:flowers_app/core/constants/app_colors.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
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
        viewModel.doIntent(ChangeOrdersFilterEvent(OrderFilter.pending));
      } else {
        viewModel.doIntent(ChangeOrdersFilterEvent(OrderFilter.completed));
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(context.l10n.myOrders),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                height: 4.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.gray.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              TabBar(
                controller: _tabController,
                dividerColor: Colors.transparent,
                labelColor: AppColors.mainColor,
                unselectedLabelColor: AppColors.gray,
                indicatorSize: TabBarIndicatorSize.tab,

                indicator: RoundedRectangleTabIndicator(
                  color: AppColors.mainColor,
                  weight: 4.0,
                ),

                tabs: [
                  Tab(text: context.l10n.active),
                  Tab(text: context.l10n.completed),
                ],
              ),
            ],
          ),
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
