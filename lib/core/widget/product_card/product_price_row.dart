import 'package:flowers_app/Features/products/domain/entities/product_entity.dart';
import 'package:flowers_app/core/widget/product_card/product_card_discount.dart';
import 'package:flowers_app/core/widget/product_card/product_card_old_price.dart';
import 'package:flowers_app/core/widget/product_card/product_card_price.dart';
import 'package:flutter/material.dart';

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
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: constraints.maxHeight * 0.01,
        horizontal: screenWidth * 0.01,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ProductCardPrice(priceAfterDiscount: product.priceAfterDiscount),
          ProductCardOldPrice(price: product.price),
          if (product.discount > 0)
            ProductCardDiscount(discount: product.discount),
        ],
      ),
    );
  }
}
