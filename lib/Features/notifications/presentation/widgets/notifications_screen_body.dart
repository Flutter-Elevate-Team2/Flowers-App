import 'package:flowers_app/Features/notifications/presentation/view_model/notification_event.dart';
import 'package:flowers_app/Features/notifications/presentation/view_model/notification_state.dart';
import 'package:flowers_app/Features/notifications/presentation/view_model/notification_view_model.dart';
import 'package:flowers_app/Features/notifications/presentation/widgets/notification_empty_widget.dart';
import 'package:flowers_app/Features/notifications/presentation/widgets/notification_error_screen.dart';
import 'package:flowers_app/Features/notifications/presentation/widgets/notification_item.dart';
import 'package:flowers_app/Features/notifications/presentation/widgets/notifications_shimmer.dart';
import 'package:flowers_app/core/app_router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class NotificationScreenBody extends StatefulWidget {
  const NotificationScreenBody({super.key});

  @override
  State<NotificationScreenBody> createState() => _NotificationScreenBodyState();
}

class _NotificationScreenBodyState extends State<NotificationScreenBody> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<NotificationViewModel>().doIntent(GetNotificationsEvent());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationViewModel, NotificationState>(
      builder: (context, state) {
        final notificationState = state.notificationsState;
        if (notificationState == null || notificationState.isLoading == true) {
          return const NotificationShimmer();
        }

        // ── Error State ──────────────────────────────────────────────────────
        if (notificationState.errorMessage != null) {
          return NotificationError(
            message: notificationState.errorMessage!,
            onRetry: () => context.read<NotificationViewModel>().doIntent(
              GetNotificationsEvent(),
            ),
          );
        }

        final notifications = notificationState.data ?? [];

        // ── Empty State ──────────────────────────────────────────────────────
        if (notifications.isEmpty) {
          return const NotificationEmpty();
        }

        // ── Success State ────────────────────────────────────────────────────
        return ListView.builder(
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            final notification = notifications[index];
            return GestureDetector(
              onTap: () {
                if (!notification.isRead) {
                  context.read<NotificationViewModel>().doIntent(
                    MarkNotificationReadEvent(notificationId: notification.id),
                  );
                }
                if (notification.orderId != null &&
                    notification.orderId!.isNotEmpty) {
                  context.pushNamed(
                    Routes.trackOrderName,
                    pathParameters: {'orderId': notification.orderId!},
                  );
                }
              },
              child: NotificationItem(notification: notification),
            );
          },
        );
      },
    );
  }
}
