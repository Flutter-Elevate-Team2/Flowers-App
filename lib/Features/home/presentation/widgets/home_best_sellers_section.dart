import 'package:flowers_app/Features/home/domain/entities/best_seller_entity.dart';
import 'package:flowers_app/Features/home/presentation/widgets/product_item.dart';
import 'package:flowers_app/Features/home/presentation/widgets/section_header.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

class HomeBestSellersSection extends StatelessWidget {
  final List<BestSellerEntity> bestSellers;
  final double screenWidth;

  const HomeBestSellersSection({
    super.key,
    required this.bestSellers,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    const double figmaWidth = 375.0;
    final double productItemWidth = (screenWidth * (131 / figmaWidth)).clamp(
      120.0,
      180.0,
    );
    final double productListHeight = productItemWidth * 1.6;

    if (bestSellers.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        SectionHeader(title: context.l10n.bestSeller, onViewAllTap: () {}),
        const SizedBox(height: 12),
        SizedBox(
          height: productListHeight,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: bestSellers.length,
            separatorBuilder: (context, index) =>
                SizedBox(width: screenWidth * 0.04),
            itemBuilder: (context, index) {
              final product = bestSellers[index];
              return ProductItem(
                name: product.name,
                price: product.price.toString(),
                imageUrl: product.imageUrl,
                width: productItemWidth,
              );
            },
          ),
        ),
      ],
    );
  }
}
