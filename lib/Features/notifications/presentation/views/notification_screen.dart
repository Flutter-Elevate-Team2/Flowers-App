import 'package:flowers_app/Features/notifications/presentation/widgets/notifications_screen_body.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flowers_app/core/theming/app_theming.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

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
          context.l10n.notifications,
          style: AppTheme.lightTheme.appBarTheme.titleTextStyle,
        ),
        centerTitle: false,
        elevation: 0,
        backgroundColor: AppTheme.lightTheme.appBarTheme.backgroundColor,
      ),
      body: const NotificationScreenBody(),
    );
  }
}
