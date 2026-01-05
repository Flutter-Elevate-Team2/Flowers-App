import 'package:flowers_app/Features/commerce/presentation/home/widgets/shimmers/section_header_shimmer_loading.dart';
import 'package:flowers_app/core/widget/app_shimmer.dart';
import 'package:flutter/material.dart';

class HomeCategoriesShimmer extends StatelessWidget {
  final double screenWidth;

  const HomeCategoriesShimmer({super.key, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    const double figmaWidth = 375.0;
    final double categoryBoxSize = (screenWidth * (68 / figmaWidth)).clamp(
      60.0,
      100.0,
    );
    final double categoryListHeight = categoryBoxSize * 1.4;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeaderShimmerLoading(),
        const SizedBox(height: 12),
        SizedBox(
          height: categoryListHeight,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 6,
            separatorBuilder: (context, index) =>
                SizedBox(width: screenWidth * 0.04),
            itemBuilder: (context, index) {
              return SizedBox(
                width: categoryBoxSize,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppShimmer(
                      width: categoryBoxSize,
                      height: categoryBoxSize * 0.94,
                      radius: 20,
                    ),
                    const SizedBox(height: 6),
                    AppShimmer(width: categoryBoxSize * 0.7, height: 12),
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
