import 'package:flowers_app/Features/home/presentation/widgets/product_card_discount.dart';
import 'package:flowers_app/Features/home/presentation/widgets/product_card_old_price.dart';
import 'package:flowers_app/Features/home/presentation/widgets/product_card_price.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/product_entity.dart';

class ProductPriceRow extends StatelessWidget {
  final ProductEntity product;
  final BoxConstraints constraints;
  final double screenWidth;

  const ProductPriceRow({
    super.key,
    required this.product,
    required this.constraints,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ProductCardPrice(priceAfterDiscount: product.priceAfterDiscount),
        const SizedBox(width: 8),
        ProductCardOldPrice(price: product.price),
        const SizedBox(width: 8),
        if (product.discount > 0)
          ProductCardDiscount(discount: product.discount),
      ],
    );
  }
}