import 'package:flowers_app/core/widget/app_shimmer.dart';
import 'package:flutter/material.dart';

class ProfileHeaderShimmer extends StatelessWidget {
  const ProfileHeaderShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          // Profile Image
          const AppShimmer.circle(size: 100),
          const SizedBox(height: 16),
          // Name
          const AppShimmer(width: 150, height: 20),
          const SizedBox(height: 8),
          // Email
          const AppShimmer(width: 200, height: 16),
          const SizedBox(height: 16),
          // Edit Profile Button
          AppShimmer(width: double.infinity, height: 48, radius: 24),
        ],
      ),
    );
  }
}
