import 'package:flowers_app/Features/commerce/domain/entities/product_entities/product_entity.dart';
import 'package:flowers_app/Features/commerce/presentation/products/widgets/shared/product_card/add_to_cart_button.dart';
import 'package:flowers_app/Features/commerce/presentation/products/widgets/shared/product_card/product_card_image.dart';
import 'package:flowers_app/Features/commerce/presentation/products/widgets/shared/product_card/product_card_title.dart';
import 'package:flowers_app/Features/commerce/presentation/products/widgets/shared/product_card/product_price_row.dart';
import 'package:flutter/material.dart';

class ProductCardBody extends StatelessWidget {
  final BoxConstraints constraints;
  final double screenWidth;
  final ProductEntity product;
  final VoidCallback? onAddToCart;

  const ProductCardBody({
    super.key,
    required this.constraints,
    required this.screenWidth,
    required this.product,
    this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProductCardImage(
          imageUrl: product.imgCover,
          height: constraints.maxHeight * 0.55,
        ),
        SizedBox(height: constraints.maxHeight * 0.03),
        ProductCardTitle(title: product.title, screenWidth: screenWidth),
        ProductPriceRow(
          product: product,
          constraints: constraints,
          screenWidth: screenWidth,
        ),
        SizedBox(height: constraints.maxHeight * 0.09),
        AddToCartButton(constraints: constraints, onPressed: onAddToCart),
      ],
    );
  }
}
