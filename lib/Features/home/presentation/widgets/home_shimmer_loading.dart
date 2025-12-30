import 'package:flowers_app/Features/home/presentation/widgets/section_header_shimmer_loading.dart';
import 'package:flowers_app/core/widgets/app_shimmer.dart';
import 'package:flutter/material.dart';

class HomeShimmerLoading extends StatelessWidget {
  const HomeShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double screenWidth = constraints.maxWidth;
        const double figmaWidth = 375.0;
        final double categoryBoxSize = (screenWidth * (68 / figmaWidth)).clamp(
          60.0,
          100.0,
        );
        final double productItemWidth = (screenWidth * (131 / figmaWidth))
            .clamp(120.0, 180.0);

        final double categoryListHeight = categoryBoxSize * 1.4;
        final double productListHeight = productItemWidth * 1.6;

        return SafeArea(
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.04,
                vertical: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const AppShimmer.circle(size: 20),
                      const SizedBox(width: 4),
                      const AppShimmer(width: 80, height: 20),
                      const SizedBox(width: 12),
                      Expanded(child: AppShimmer(height: 36, radius: 8)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Row(
                    children: [
                      AppShimmer.circle(size: 16),
                      SizedBox(width: 4),
                      AppShimmer(width: 120, height: 14),
                    ],
                  ),

                  const SizedBox(height: 32),

                  SectionHeaderShimmerLoading(),
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
                              AppShimmer(
                                width: categoryBoxSize * 0.7,
                                height: 12,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 32),

                  SectionHeaderShimmerLoading(),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: productListHeight,
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
                              AspectRatio(
                                aspectRatio: 1.0,
                                child: AppShimmer(
                                  height: double.infinity,
                                  width: double.infinity,
                                  radius: 12,
                                ),
                              ),
                              const SizedBox(height: 8),
                              AppShimmer(
                                width: productItemWidth * 0.9,
                                height: 14,
                              ),
                              const SizedBox(height: 4),
                              AppShimmer(
                                width: productItemWidth * 0.4,
                                height: 14,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 32),
                  SectionHeaderShimmerLoading(),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: productListHeight * 0.9,
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
                              const Expanded(
                                flex: 1,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: AppShimmer(width: 80, height: 14),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
