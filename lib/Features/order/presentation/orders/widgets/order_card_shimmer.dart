import 'package:flowers_app/core/constants/app_colors.dart';
import 'package:flowers_app/core/widget/app_shimmer.dart';
import 'package:flutter/material.dart';

class OrderCardShimmer extends StatelessWidget {
  const OrderCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16, left: 28, right: 28),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.gray),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppShimmer(
            width: MediaQuery.of(context).size.width * 0.37,
            height: MediaQuery.of(context).size.height * .15,
            radius: 12,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const AppShimmer(height: 16, width: double.infinity, radius: 4),
                const SizedBox(height: 4),
                const AppShimmer(height: 20, width: 60, radius: 4),
                const SizedBox(height: 4),
                const AppShimmer(height: 14, width: 100, radius: 4),
                const SizedBox(height: 16),
                const AppShimmer(
                  height: 38,
                  width: double.infinity,
                  radius: 25,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
