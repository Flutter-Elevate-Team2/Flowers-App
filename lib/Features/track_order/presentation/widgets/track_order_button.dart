import 'package:flowers_app/Features/track_order/domain/entities/order_tracking_entity.dart';
import 'package:flowers_app/core/app_router/app_router.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flowers_app/core/widget/custom_button.dart';
import 'package:flutter/material.dart';
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
          SizedBox(width: 9),

          Expanded(
            flex: 3,
            child: CustomButton(
              title: context.l10n.orderDelivered,
              onPressed: () {},
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
