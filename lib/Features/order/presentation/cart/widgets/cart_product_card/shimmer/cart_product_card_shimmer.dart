import 'package:flowers_app/core/constants/app_colors.dart';
import 'package:flowers_app/core/widget/app_shimmer.dart';
import 'package:flutter/material.dart';

class CartProductCardShimmer extends StatelessWidget {
  const CartProductCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          padding: EdgeInsets.all(8),
          height: 120,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.gray.withValues(alpha: 0.5),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image Section
                Container(
                  margin: EdgeInsets.only(right: 8),
                  width: 100,
                  height: 100,
                  child: AppShimmer(
                    height: double.infinity,
                    width: double.infinity,
                    radius: 12,
                  ),
                ),

                // Content Section
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      AppShimmer(
                        width: MediaQuery.of(context).size.width * 0.2,
                        height: 14,
                      ),
                      //Description
                      SizedBox(height: 14),
                      AppShimmer(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: 14,
                      ),
                      Spacer(),
                      Padding(
                        padding: EdgeInsetsGeometry.only(bottom: 8),
                        child: AppShimmer(
                          width: MediaQuery.of(context).size.width * 0.1,
                          height: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
