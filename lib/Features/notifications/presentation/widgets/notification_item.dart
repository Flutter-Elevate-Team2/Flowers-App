import 'package:flowers_app/Features/notifications/domain/entities/notification_entity.dart';
import 'package:flowers_app/core/constants/app_colors.dart';
import 'package:flowers_app/core/helpers/relateve_time_en.dart';
import 'package:flowers_app/core/theming/app_theming.dart';
import 'package:flutter/material.dart';

class NotificationItem extends StatelessWidget {
  final NotificationEntity notification;
  const NotificationItem({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isUnread = !notification.isRead;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: isUnread
            ? const Color(0xFFFDF2F5) 
            : theme.scaffoldBackgroundColor,
        border: Border(
          bottom: BorderSide(
            color: AppColors.notificationDivider,
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Bell Icon ────────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Icon(
              Icons.notifications_none_outlined,
              size: 22,
              color: isUnread
                  ? const Color(0xFFD81B60)
                  : theme.iconTheme.color?.withValues(alpha: 0.45),
            ),
          ),
          const SizedBox(width: 12),

          // ── Content ──────────────────────────────────────────────────────
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Title Row + Time (top right) ─────────────────────────
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        notification.title,
                        style: AppTheme.notificationTitleStyle.copyWith(
                          // Bold when unread, medium weight when read
                          fontWeight: isUnread
                              ? FontWeight.w700
                              : FontWeight.w500,
                          color: isUnread
                              ? const Color(0xFFD81B60)
                              : AppTheme.notificationTitleStyle.color,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // ── Relative time (top-right, English) ────────────────
                    Text(
                      relativeTimeEn(notification.sentAt),
                      style: AppTheme.notificationBodyStyle.copyWith(
                        fontSize: 10.5,
                        color: isUnread
                            ? const Color(0xFFD81B60)
                            : AppTheme.notificationBodyStyle.color?.withValues(
                                alpha: 0.7,
                              ),
                        fontWeight: isUnread
                            ? FontWeight.w600
                            : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),

                // ── Body ─────────────────────────────────────────────────
                Text(
                  notification.body,
                  style: AppTheme.notificationBodyStyle.copyWith(
                    fontWeight: isUnread ? FontWeight.w500 : FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),

          // ── Unread Red Dot ───────────────────────────────────────────────
          if (isUnread) ...[
            const SizedBox(width: 8),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Container(
                width: 9,
                height: 9,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFD81B60),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

}
