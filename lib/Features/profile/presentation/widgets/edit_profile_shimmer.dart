import 'package:flowers_app/core/widget/app_shimmer.dart';
import 'package:flutter/material.dart';

class EditProfileShimmer extends StatelessWidget {
  const EditProfileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      child: Column(
        children: [
          // Profile Avatar
          const AppShimmer.circle(size: 100),
          const SizedBox(height: 32),
          // First Name & Last Name Row
          Row(
            children: [
              Expanded(child: AppShimmer(height: 56)),
              const SizedBox(width: 16),
              Expanded(child: AppShimmer(height: 56)),
            ],
          ),
          const SizedBox(height: 16),
          // Email Field
          AppShimmer(height: 56),
          const SizedBox(height: 16),
          // Phone Field
          AppShimmer(height: 56),
          const SizedBox(height: 16),
          // Password Field
          AppShimmer(height: 56),
          const SizedBox(height: 24),
          // Gender Section
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppShimmer(width: 80, height: 16),
              const SizedBox(height: 8),
              Row(
                children: [
                  const AppShimmer(width: 100, height: 40),
                  const SizedBox(width: 24),
                  const AppShimmer(width: 100, height: 40),
                ],
              ),
            ],
          ),
          const SizedBox(height: 48),
          // Update Button
          AppShimmer(height: 50, radius: 25),
        ],
      ),
    );
  }
}
