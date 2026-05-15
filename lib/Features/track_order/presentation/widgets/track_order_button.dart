import 'package:flowers_app/Features/order/presentation/orders/view_model/orders_event.dart';
import 'package:flowers_app/Features/order/presentation/orders/view_model/orders_view_model.dart';
import 'package:flowers_app/Features/track_order/domain/entities/order_tracking_entity.dart';
import 'package:flowers_app/Features/track_order/presentation/view_model/track_order_event.dart';
import 'package:flowers_app/Features/track_order/presentation/view_model/track_order_state.dart';
import 'package:flowers_app/Features/track_order/presentation/view_model/track_order_view_model.dart';
import 'package:flowers_app/core/app_router/app_router.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flowers_app/core/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class TrackOrderButton extends StatelessWidget {
  final bool isDelivered;
  final OrderTrackingEntity order;

  const TrackOrderButton({
    this.isDelivered = false,
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    if (isDelivered) {
      return Row(
        children: [
          Expanded(
            flex: 2,
            child: CustomButton(
              title: context.l10n.showMap,
              onPressed: () {
                context.push(Routes.mapPath, extra: {'order': order});
              },
            ),
          ),
          const SizedBox(width: 9),

          Expanded(
            flex: 3,
            child: BlocConsumer<OrderStatusViewModel, TrackOrderStatusState>(
              listenWhen: (prev, next) =>
                  prev.sendSilentNotificationState !=
                  next.sendSilentNotificationState,
              buildWhen: (prev, next) =>
                  prev.sendSilentNotificationState !=
                  next.sendSilentNotificationState,

              listener: (context, state) {
                final silentState = state.sendSilentNotificationState;

                if (silentState?.data == true) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(context.l10n.confirmDeliverySuccess),
                      backgroundColor: Colors.green,
                    ),
                  );
                  context.read<OrdersViewModel>().doIntent(
                    GetUserOrdersEvent(),
                  );
                } else if (silentState?.errorMessage != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(silentState!.errorMessage!),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              builder: (context, state) {
                final isLoading =
                    state.sendSilentNotificationState?.isLoading == true;

                return isLoading
                    ? const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: null,
                            child: SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      )
                    : CustomButton(
                        title: context.l10n.orderDelivered,

                        onPressed: () {
                          final orderData = state.orderState?.data;
                          final orderId = orderData?.id;
                          final driverToken = orderData?.driver?.token;

                          if (orderId != null && driverToken != null) {
                            context.read<OrderStatusViewModel>().doIntent(
                              context,
                              SendSilentNotificationEvent(
                                orderId: orderId,
                                driverToken: driverToken,
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  context.l10n.driverDataIncomplete,
                                ),
                              ),
                            );
                          }
                        },
                      );
              },
            ),
          ),
        ],
      );
    }
    return CustomButton(
      title: context.l10n.showMap,
      onPressed: () {
        context.push(Routes.mapPath, extra: {'order': order});
      },
    );
  }
}
