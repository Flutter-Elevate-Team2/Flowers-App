import 'package:flowers_app/Features/products/domain/entities/product_entity.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final ProductEntity product;
  final VoidCallback? onTap;

  const ProductCard({super.key, this.onTap, required this.product});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          decoration: ProductCardDecoration.build(context),
          child: Padding(
            padding: EdgeInsets.all(screenWidth * 0.02),
            child: InkWell(
              onTap: onTap,
              child: ProductCardBody(
                constraints: constraints,
                screenWidth: screenWidth,
                product: product,
              ),
            ),
          ),
        );
      },
    );
  }
}
