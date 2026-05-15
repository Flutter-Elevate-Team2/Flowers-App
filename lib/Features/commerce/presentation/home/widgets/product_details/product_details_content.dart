import 'package:flowers_app/Features/commerce/domain/entities/product_entities/product_entity.dart';
import 'package:flowers_app/core/constants/app_colors.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flowers_app/core/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class ProductDetailsContent extends StatelessWidget {
  final ProductEntity product;

  const ProductDetailsContent({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Price and Status Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "EGP ${_formatPrice(product.priceAfterDiscount)}",
                      style: textTheme.bodyLarge?.copyWith(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      locale.includeTax,
                      style: textTheme.bodySmall?.copyWith(
                        color: AppColors.gray,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "${locale.status}: ",
                      style: textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.black,
                      ),
                    ),
                    Text(
                      product.quantity > 0 ? locale.inStock : locale.outOfStock,
                      style: textTheme.bodyMedium?.copyWith(
                        color: AppColors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Product Title
            Text(
              product.title,
              style: textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.black,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 24),

            // Description Section
            Text(
              locale.description,
              style: textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.black,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              product.description,
              style: textTheme.bodySmall?.copyWith(
                color: AppColors.gray,
                height: 1.5,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 24),

            // Bouquet Include Section
            Text(
              context.l10n.bouquetInclude,
              style: textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.black,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 12),
            _BouquetIncludeItem(text: "Pink roses:15"),
            _BouquetIncludeItem(text: "White wrap"),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  String _formatPrice(int price) {
    return price.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }
}

class _BouquetIncludeItem extends StatelessWidget {
  final String text;

  const _BouquetIncludeItem({required this.text});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Text(
            text,
            style: textTheme.bodySmall?.copyWith(
              color: AppColors.gray,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
