import 'package:flowers_app/Features/commerce/domain/entities/product_entities/product_entity.dart';
import 'package:flowers_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class ProductCardPriceRow extends StatelessWidget {
  final ProductEntity product;

  const ProductCardPriceRow({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Current Price
        if (product.discount == 0)
          Text(
            'EGP ${product.price}',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.black,
            ),
          ),
        if (product.discount > 0)
          Text(
            'EGP ${product.priceAfterDiscount}',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.black,
            ),
          ),
        if (product.discount > 0) const SizedBox(width: 8),
        // Old Price
        if (product.discount > 0)
          Text(
            '${product.price}',
            style: const TextStyle(
              fontSize: 12,
              decoration: TextDecoration.lineThrough,
              color: Colors.grey,
              fontWeight: FontWeight.w400,
            ),
          ),
        const SizedBox(width: 8),

        // Discount Percentage
        if (product.discount > 0)
          Text(
            '${product.discount}%',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.green,
            ),
          ),
      ],
    );
  }
}
