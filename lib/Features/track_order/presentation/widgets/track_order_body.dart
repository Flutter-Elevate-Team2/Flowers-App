import 'package:flowers_app/Features/track_order/presentation/view_model/track_order_state.dart';
import 'package:flowers_app/Features/track_order/presentation/view_model/track_order_view_model.dart';
import 'package:flowers_app/Features/track_order/presentation/widgets/driver_info.dart';
import 'package:flowers_app/Features/track_order/presentation/widgets/estimated_arrival.dart';
import 'package:flowers_app/Features/track_order/presentation/widgets/order_time_line.dart';
import 'package:flowers_app/Features/track_order/presentation/widgets/track_order_button.dart';
import 'package:flowers_app/Features/track_order/presentation/widgets/track_order_shimmer.dart';
import 'package:flowers_app/Features/track_order/presentation/widgets/vehicle_image.dart';
import 'package:flowers_app/core/constants/app_colors.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TrackOrderBody extends StatelessWidget {
  const TrackOrderBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderStatusViewModel, TrackOrderStatusState>(
      buildWhen: (prev, next) =>
          prev.orderState?.data?.status != next.orderState?.data?.status ||
          prev.statusHistory != next.statusHistory,
      builder: (context, state) {
        final history = Map.fromEntries(
          (state.statusHistory.entries.toList()
            ..sort((a, b) => a.value.compareTo(b.value))),
        );
        final orderState = state.orderState;

        /// Loading
        if (orderState?.isLoading == true) {
          return TrackOrderShimmer();
        }

        /// Error
        if (orderState?.errorMessage != null) {
          return Center(child: Text(orderState!.errorMessage!));
        }

        final order = orderState?.data;

        if (order == null) {
          return Center(child: Text(context.l10n.noProductsFound));
        }

        final estimatedArrival = history.isNotEmpty
            ? history.values.first.add(const Duration(hours: 1))
            : DateTime.now().add(const Duration(hours: 1));

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Estimated arrival
                EstimatedArrival(date: estimatedArrival),

                Padding(
                  padding: EdgeInsetsGeometry.symmetric(vertical: 16),
                  child: Divider(color: AppColors.gray.withValues(alpha: 0.4)),
                ),

                DriverInfo(name: order.driver!.name , phone: order.driver!.phone,),

                const SizedBox(height: 20),

                VehicleImage(order.driver!.vehicleImage),

                /// Timeline dynamic
                OrderTimeline(currentStatus: order.status, history: history),

                /// Button
                TrackOrderButton(
                  isDelivered: order.status == 'delivered',
                  order: order,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
