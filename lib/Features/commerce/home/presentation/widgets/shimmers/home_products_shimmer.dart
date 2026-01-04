import 'package:flowers_app/Features/commerce/home/presentation/widgets/shimmers/section_header_shimmer_loading.dart';
import 'package:flowers_app/core/widget/app_shimmer.dart';
import 'package:flutter/material.dart';

class HomeProductsShimmer extends StatelessWidget {
  final double screenWidth;
  final bool isOccasion;

  const HomeProductsShimmer({
    super.key,
    required this.screenWidth,
    this.isOccasion = false,
  });

  @override
  Widget build(BuildContext context) {
    const double figmaWidth = 375.0;
    final double productItemWidth = (screenWidth * (131 / figmaWidth)).clamp(
      120.0,
      180.0,
    );

    final double productListHeight = productItemWidth * 1.6;
    final double listHeight = isOccasion
        ? productListHeight * 0.9
        : productListHeight;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeaderShimmerLoading(),
        const SizedBox(height: 12),
        SizedBox(
          height: listHeight,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 4,
            separatorBuilder: (context, index) =>
                SizedBox(width: screenWidth * 0.04),
            itemBuilder: (context, index) {
              return SizedBox(
                width: productItemWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: AppShimmer(
                        height: double.infinity,
                        width: double.infinity,
                        radius: 12,
                      ),
                    ),
                    const SizedBox(height: 8),
                    if (isOccasion)
                      const Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: AppShimmer(width: 80, height: 14),
                        ),
                      )
                    else ...[
                      AppShimmer(width: productItemWidth * 0.9, height: 14),
                      const SizedBox(height: 4),
                      AppShimmer(width: productItemWidth * 0.4, height: 14),
                    ],
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
