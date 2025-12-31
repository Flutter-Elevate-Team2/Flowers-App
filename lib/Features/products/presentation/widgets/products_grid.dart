import 'package:flowers_app/Features/products/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';

import 'product_card.dart';

class ProductsGrid extends StatelessWidget {
  final List<ProductEntity> products;
  final bool isLoadingMore;
  final ScrollController? controller;

  const ProductsGrid({
    required this.products,
    this.isLoadingMore = false,
    this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: controller,
      itemCount: products.length + (isLoadingMore ? 1 : 0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.65,
      ),
      itemBuilder: (context, index) {
        final product = products[index];
        if (index < products.length) {
          return ProductCard(product: products[index]);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
