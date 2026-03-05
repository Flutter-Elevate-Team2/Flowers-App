import 'package:flowers_app/Features/track_order/domain/entities/order_status.dart';
import 'package:flowers_app/Features/track_order/presentation/widgets/state_time_line.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderTimeline extends StatelessWidget {
  final String currentStatus;
  final Map<String, DateTime> history;

  const OrderTimeline({required this.currentStatus,required this.history, super.key});

  int _getStepIndex() {
    final statusEnum = OrderStatusX.fromFirebase(currentStatus);
    return OrderStatus.values.indexOf(statusEnum);
  }

  String _formatTime(String key) {
    final date = history[key];
    return date != null ?  DateFormat(
      'dd MMM yyyy, hh:mm a',
    ).format(date) : "";
  }
  @override
  Widget build(BuildContext context) {
    final currentIndex = _getStepIndex();

    return Column(
      children: [
        StateTimeLine(
          isActive: currentIndex >= 1,
          currentIndex: currentIndex,
          title: context.l10n.receivedYourOrder,
          time: _formatTime("arrived_pickup"),
        ),
        StateTimeLine(
          isActive: currentIndex >= 2,
          currentIndex: currentIndex,
          title: context.l10n.preparingYourOrder,
          time: _formatTime("start_deliver"),
        ),
        StateTimeLine(
          isActive: currentIndex >= 3,
          currentIndex: currentIndex,
          isLast: false,
          title: context.l10n.arrived,
          time: _formatTime("arrived_user"),
        ),
        StateTimeLine(
          isActive: currentIndex >= 4,
          currentIndex: currentIndex,
          isLast: true,
          title: context.l10n.delivered,
          time: _formatTime("delivered"),
        ),

      ],
    );
  }
}
