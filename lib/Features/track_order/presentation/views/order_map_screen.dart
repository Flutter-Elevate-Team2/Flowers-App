import 'package:flowers_app/Features/track_order/domain/entities/order_tracking_entity.dart';
import 'package:flowers_app/Features/track_order/presentation/view_model/track_order_event.dart';
import 'package:flowers_app/Features/track_order/presentation/view_model/track_order_state.dart';
import 'package:flowers_app/Features/track_order/presentation/view_model/track_order_view_model.dart';
import 'package:flowers_app/Features/track_order/presentation/widgets/driver_info.dart';
import 'package:flowers_app/Features/track_order/presentation/widgets/estimated_arrival.dart';
import 'package:flowers_app/Features/track_order/presentation/widgets/map/custom_map_back_button.dart';
import 'package:flowers_app/Features/track_order/presentation/widgets/map/order_map_body.dart';
import 'package:flowers_app/core/constants/app_colors.dart';
import 'package:flowers_app/core/di/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderMapScreen extends StatelessWidget {
  final OrderTrackingEntity order;

  const OrderMapScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      getIt<OrderStatusViewModel>()
        ..doIntent(context, FetchOrderDetailsEvent(order.id)),
      child: Scaffold(
        body: BlocBuilder<OrderStatusViewModel, TrackOrderStatusState>(
          builder: (context, state) {
            final history = Map.fromEntries(
              (state.statusHistory.entries.toList()
                ..sort((a, b) => a.value.compareTo(b.value))),
            );

            final estimatedArrival = history.isNotEmpty
                ? history.values.first.add(const Duration(hours: 1))
                : DateTime.now().add(const Duration(hours: 1));

            return Stack(
              children: [
                const OrderMapBody(),

                SafeArea(
                  child: Stack(
                    children: [
                      Positioned(
                        top: 10,
                        left: 20,
                        child: const CustomMapBackButton(),
                      ),

                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 24,
                          ),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(24),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 10,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              EstimatedArrival(date: estimatedArrival),
                              const SizedBox(height: 16),
                              Divider(color: AppColors.gray.withValues(alpha: 0.4)),
                              const SizedBox(height: 16),
                              DriverInfo(name: order.driver?.name ?? ""),
                              const SizedBox(height: 24),
                              SizedBox(
                                width: double.infinity,
                                height: 55,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.mainColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    elevation: 0,
                                  ),
                                  onPressed: () {},
                                  child: const Text(
                                    "Order details",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}