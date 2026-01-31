import 'package:flowers_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class OrderCardShimmer extends StatelessWidget {
  const OrderCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 28),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              width: 110,
              height: 130,
              decoration: BoxDecoration(
                color: AppColors.lightPink,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _line(width: double.infinity),
                  const SizedBox(height: 8),
                  _line(width: 120),
                  const SizedBox(height: 8),
                  _line(width: 180),
                  const SizedBox(height: 16),
                  Container(
                    height: 38,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(25),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _line({required double width}) {
    return Container(
      width: width,
      height: 14,
      color: Colors.grey,
    );
  }
}
