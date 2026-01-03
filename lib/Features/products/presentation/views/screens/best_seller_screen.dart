import 'package:flowers_app/Features/home/domain/entities/best_seller_entity.dart';
import 'package:flowers_app/Features/products/domain/entities/product_entity.dart';
import 'package:flowers_app/core/app_router/app_router.dart';
import 'package:flowers_app/core/constants/app_colors.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flowers_app/core/widget/product_card/product_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
class BestSeller extends StatelessWidget {
  final List<BestSellerEntity>? bestSellers;

  const BestSeller({super.key, this.bestSellers});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        leading: GestureDetector(
          child: const Icon(Icons.arrow_back_ios),
          onTap: () {
            context.pop();
          },
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
            context.l10n.bestSeller,
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
            context.l10n.occasionDescription,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: AppColors.gray),
            ),
          ],
        ),
        centerTitle: false,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          childAspectRatio: 0.6, // Adjusted for ProductCard
        ),
        itemCount: bestSellers?.length ?? 0,
        itemBuilder: (context, index) {
          final item = bestSellers![index];
          // Map BestSellerEntity to ProductEntity
          final product = ProductEntity(
            id: item.id,
            title: item.name,
            slug: '',
            description: item.description,
            imgCover: item.imageUrl,
            images: item.images,
            price: item.price.toInt(),
            priceAfterDiscount: item.priceAfterDiscount.toInt(),
            quantity: item.quantity.toInt(),
            categoryId: '',
            occasionId: '',
            sold: 0,
            rateAvg: 0,
            rateCount: 0,
            isInWishlist: false,
            discount: item.discount.toInt(),
          );
          return ProductCard(
            product: product,
            onTap: () {
              context.pushNamed(Routes.productDetailsName, extra: product);
            },
          );
        },
      ),
    );
  }
}