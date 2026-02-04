import 'package:flowers_app/Features/notifications/presentation/view_model/notification_state.dart';
import 'package:flowers_app/Features/notifications/presentation/view_model/notification_view_model.dart';
import 'package:flowers_app/Features/notifications/presentation/widgets/notification_item.dart';
import 'package:flowers_app/core/theming/app_theming.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: AppTheme.lightTheme.iconTheme.color,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Notification',
          style: AppTheme.lightTheme.appBarTheme.titleTextStyle,
        ),
        centerTitle: false,
        elevation: 0,
        backgroundColor: AppTheme.lightTheme.appBarTheme.backgroundColor,
      ),
      body: BlocBuilder<NotificationViewModel, NotificationState>(
        builder: (context, state) {
          final notificationState = state.notificationsState;

          if (notificationState?.isLoading == true) {
            return const Center(child: CircularProgressIndicator());
          }

          if (notificationState?.errorMessage != null) {
            return Center(child: Text(notificationState!.errorMessage!));
          }

          final notifications = notificationState?.data ?? [];

          if (notifications.isEmpty) {
            return const Center(child: Text('No notifications'));
          }

          return ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              return NotificationItem(notification: notifications[index]);
            },
          );
        },
      ),
    );
  }
}
