import 'package:flowers_app/Features/products/domain/entities/products_entity.dart';
import 'package:flutter/material.dart';

import 'product_card.dart';

class ProductsGrid extends StatelessWidget {
  final List<ProductsEntity> products;

   const ProductsGrid(this.products,{super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.65,
      ),
      itemBuilder: (context, index) {
        final product = products[index];
        return ProductCard(
          name: product.title,
          image: product.imgCover,
          price: product.price,
          oldPrice: product.price,
          discount: 55,
        );
      },
    );
  }
}
