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
    // Dispatch the GetProfileEvent when the screen is initialized
    context.read<ProfileViewModel>().doIntent(GetProfileEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: ProfileScreenBody());
  }
}
