import 'package:flowers_app/core/constants/app_colors.dart';
import 'package:flowers_app/core/widget/app_shimmer.dart';

import 'package:flutter/material.dart';

class TrackOrderShimmer extends StatelessWidget {
  const TrackOrderShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    const steps = 4;
    return Padding(

      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Estimated arrival
          AppShimmer(
            width: MediaQuery.of(context).size.width * 0.25,
            height: 14,
          ),
          SizedBox(height: 8),
          AppShimmer(
            width: MediaQuery.of(context).size.width * 0.4,
            height: 14,
          ),

          Padding(
            padding: EdgeInsetsGeometry.symmetric(vertical: 16),
            child: Divider(color: AppColors.gray.withValues(alpha: 0.4)),
          ),

          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppShimmer(height: 20, width: 20),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppShimmer(width: double.infinity, height: 14),
                    const SizedBox(height: 4),
                    AppShimmer(width: double.infinity, height: 14),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              AppShimmer(width: 14, height: 14),
              const SizedBox(width: 8),
              AppShimmer(width: 14, height: 14),
            ],
          ),

          const SizedBox(height: 20),

          AppShimmer(height: MediaQuery.of(context).size.height * 0.2, width: double.infinity),
          const SizedBox(height: 20),


          /// Timeline dynamic
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: List.generate(steps, (index) {
                  final isLast = index == steps - 1;
                  return SizedBox(
                    height: 70,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Column(
                          children: [
                            AppShimmer(width: 20, height: 20, radius: 10),
                            if (!isLast)
                              Expanded(
                                child: AppShimmer(width: 2, height: double.infinity, radius: 10),
                              ),
                          ],
                        ),
                        const SizedBox(width: 12),
                         Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppShimmer(width: MediaQuery.of(context).size.width * 0.3, height: 14, radius: 10),
                              const SizedBox(height: 4),
                              AppShimmer(width: MediaQuery.of(context).size.width * 0.2, height: 12, radius: 10),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
          )          /// Button
        ],
      ),
    );
  }
}
