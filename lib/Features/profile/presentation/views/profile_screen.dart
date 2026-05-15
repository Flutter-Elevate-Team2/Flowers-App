import 'package:flowers_app/Features/notifications/presentation/view_model/notification_event.dart';
import 'package:flowers_app/Features/notifications/presentation/view_model/notification_view_model.dart';
import 'package:flowers_app/Features/profile/presentation/view_model/profile_event.dart';
import 'package:flowers_app/Features/profile/presentation/view_model/profile_view_model.dart';
import 'package:flowers_app/Features/profile/presentation/widgets/profile_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<ProfileViewModel>().doIntent(GetProfileEvent());
        // Re-dispatch here to ensure getUserId() resolves after login.
        // The ViewModel is a singleton — this cancels any stale stream
        // and reattaches with the correct, authenticated userId.
        context.read<NotificationViewModel>().doIntent(GetNotificationsEvent());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: ProfileScreenBody());
  }
}
