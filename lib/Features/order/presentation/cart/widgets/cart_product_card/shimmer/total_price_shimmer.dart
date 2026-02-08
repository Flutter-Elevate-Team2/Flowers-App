import 'package:flowers_app/core/constants/app_colors.dart';
import 'package:flowers_app/core/widget/app_shimmer.dart';
import 'package:flutter/material.dart';

class TotalPriceShimmer extends StatelessWidget {
  const TotalPriceShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppShimmer(
              width: MediaQuery.of(context).size.width * 0.15,
              height: 14,
            ),
            AppShimmer(
              width: MediaQuery.of(context).size.width * 0.1,
              height: 14,
            ),
          ],
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppShimmer(
              width: MediaQuery.of(context).size.width * 0.15,
              height: 14,
            ),
            AppShimmer(
              width: MediaQuery.of(context).size.width * 0.1,
              height: 14,
            ),
          ],
        ),
        Divider(height: 20, thickness: 1, color: AppColors.gray),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppShimmer(
              width: MediaQuery.of(context).size.width * 0.2,
              height: 14,
            ),
            AppShimmer(
              width: MediaQuery.of(context).size.width * 0.1,
              height: 14,
            ),
          ],
        ),
      ],
    );
  }
}
