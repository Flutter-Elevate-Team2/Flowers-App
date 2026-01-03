import 'package:flowers_app/Features/home/presentation/widgets/product_card_body.dart';
import 'package:flowers_app/Features/home/presentation/widgets/product_card_decoration.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/product_entity.dart';

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