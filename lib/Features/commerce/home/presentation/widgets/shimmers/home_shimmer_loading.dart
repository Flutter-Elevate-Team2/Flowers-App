import 'package:flowers_app/Features/commerce/home/presentation/widgets/shimmers/home_categories_shimmer.dart';
import 'package:flowers_app/Features/commerce/home/presentation/widgets/shimmers/home_products_shimmer.dart';
import 'package:flowers_app/core/widget/app_shimmer.dart';
import 'package:flutter/material.dart';

class HomeShimmerLoading extends StatelessWidget {
  const HomeShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double screenWidth = constraints.maxWidth;

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
                  HomeCategoriesShimmer(screenWidth: screenWidth),
                  const SizedBox(height: 32),
                  HomeProductsShimmer(screenWidth: screenWidth),
                  const SizedBox(height: 32),
                  HomeProductsShimmer(
                    screenWidth: screenWidth,
                    isOccasion: true,
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
