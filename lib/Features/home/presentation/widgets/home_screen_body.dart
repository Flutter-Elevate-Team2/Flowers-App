import 'package:flowers_app/Features/home/presentation/widgets/category_item.dart';
import 'package:flowers_app/Features/home/presentation/widgets/home_header.dart';
import 'package:flowers_app/Features/home/presentation/widgets/occasion_item.dart';
import 'package:flowers_app/Features/home/presentation/widgets/product_item.dart';
import 'package:flowers_app/Features/home/presentation/widgets/section_header.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double screenWidth = constraints.maxWidth;
        final double screenHeight = constraints.maxHeight;

        const double figmaWidth = 375.0;

        final double categoryBoxSize = (screenWidth * (68 / figmaWidth)).clamp(
          60.0,
          100.0,
        );
        final double productItemWidth = (screenWidth * (131 / figmaWidth))
            .clamp(120.0, 180.0);
        final double occasionItemWidth = productItemWidth;

        final double categoryListHeight = categoryBoxSize * 1.35;
        final double productListHeight = productItemWidth * 1.5;

        return SafeArea(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: screenHeight),
              child: IntrinsicHeight(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.04,
                    vertical: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // --- Header ---
                      const HomeHeader(),

                      const Spacer(flex: 1),

                      // --- Categories ---
                      SectionHeader(
                        title: context.l10n.categories,
                        onViewAllTap: () {},
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: categoryListHeight,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          children: [
                            CategoryItem(
                              title: "Flowers",
                              icon: Icons.local_florist_outlined,
                              boxSize: categoryBoxSize,
                            ),
                            SizedBox(width: screenWidth * 0.04),
                            CategoryItem(
                              title: "Gift",
                              icon: Icons.card_giftcard,
                              boxSize: categoryBoxSize,
                            ),
                            SizedBox(width: screenWidth * 0.04),
                            CategoryItem(
                              title: "Card",
                              icon: Icons.card_membership,
                              boxSize: categoryBoxSize,
                            ),
                            SizedBox(width: screenWidth * 0.04),
                            CategoryItem(
                              title: "Jewellery",
                              icon: Icons.diamond_outlined,
                              boxSize: categoryBoxSize,
                            ),
                          ],
                        ),
                      ),

                      const Spacer(flex: 2),

                      // --- Best Seller ---
                      SectionHeader(
                        title: context.l10n.bestSeller,
                        onViewAllTap: () {},
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: productListHeight,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          children: [
                            ProductItem(
                              name: "Sunny",
                              price: "600",
                              width: productItemWidth,
                            ),
                            SizedBox(width: screenWidth * 0.04),
                            ProductItem(
                              name: "Red roses",
                              price: "600",
                              width: productItemWidth,
                            ),
                            SizedBox(width: screenWidth * 0.04),
                            ProductItem(
                              name: "Spring vase",
                              price: "600",
                              width: productItemWidth,
                            ),
                          ],
                        ),
                      ),

                      const Spacer(flex: 2),

                      // --- Occasions ---
                      SectionHeader(
                        title: context.l10n.occasion,
                        onViewAllTap: () {},
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: productListHeight * 0.9,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          children: [
                            OccasionItem(
                              title: "Wedding",
                              width: occasionItemWidth,
                            ),
                            SizedBox(width: screenWidth * 0.04),
                            OccasionItem(
                              title: "Birthday",
                              width: occasionItemWidth,
                            ),
                            SizedBox(width: screenWidth * 0.04),
                            OccasionItem(
                              title: "Graduation",
                              width: occasionItemWidth,
                            ),
                          ],
                        ),
                      ),

                      const Spacer(flex: 1),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
