import 'package:flowers_app/Features/commerce/domain/entities/product_entities/best_seller_entity.dart';
import 'package:flowers_app/Features/commerce/presentation/home/widgets/items/product_item.dart';
import 'package:flowers_app/Features/commerce/presentation/home/widgets/shared/section_header.dart';
import 'package:flowers_app/Features/commerce/domain/entities/product_entities/product_entity.dart';
import 'package:flowers_app/core/app_router/app_router.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
        SectionHeader(
          title: context.l10n.bestSeller,
          onViewAllTap: () {
            context.pushNamed(Routes.bestSellerName, extra: bestSellers);
          },
        ),
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
              return GestureDetector(
                onTap: () {
                  final productEntity = ProductEntity(
                    id: product.id,
                    title: product.name,
                    slug: '',
                    description: product.description,
                    imgCover: product.imageUrl,
                    images: [product.imageUrl],
                    price: product.price.toInt(),
                    priceAfterDiscount: product.price.toInt(),
                    quantity: product.quantity.toInt(),
                    categoryId: '',
                    occasionId: '',
                    sold: 0,
                    rateAvg: 0,
                    rateCount: 0,
                    isInWishlist: false,
                    discount: 0,
                  );
                  context.pushNamed(
                    Routes.productDetailsName,
                    extra: productEntity,
                  );
                },
                child: ProductItem(
                  name: product.name,
                  price: product.price.toString(),
                  imageUrl: product.imageUrl,
                  width: productItemWidth,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
