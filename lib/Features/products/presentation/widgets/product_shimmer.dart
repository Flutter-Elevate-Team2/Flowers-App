import 'package:flowers_app/core/widget/app_shimmer.dart';
import 'package:flutter/material.dart';

class ProductShimmer extends StatelessWidget {
  const ProductShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: AppShimmer(
                width: double.infinity,
                height: double.infinity,
                radius: 16,
              ),
            ),
            const SizedBox(height: 8),
            AppShimmer(width: double.infinity, height: 14),
            const SizedBox(height: 6),
            AppShimmer(
              width: MediaQuery.of(context).size.width * 0.3,
              height: 14,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppShimmer(width: 60, height: 14),
                AppShimmer(width: 40, height: 14),
                AppShimmer(width: 30, height: 14),
              ],
            ),

            const Spacer(),
            AppShimmer(width: double.infinity, height: 36, radius: 8),
          ],
        ),
      ),
    );
  }
}
