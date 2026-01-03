import 'package:flowers_app/Features/products/domain/entities/product_entity.dart';

import 'package:flowers_app/core/app_router/app_router.dart';
import 'package:flowers_app/core/widget/product_card/product_card.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

class ProductsGrid extends StatelessWidget {
  final List<ProductEntity> products;
  final bool isLoadingMore;
  final ScrollController? controller;
  final bool shrinkWrap;
  final ScrollPhysics? physics;

  const ProductsGrid({
    required this.products,
    this.isLoadingMore = false,
    this.controller,
    this.shrinkWrap = false,
    this.physics,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: controller,
      shrinkWrap: shrinkWrap,
      physics: physics ?? const NeverScrollableScrollPhysics(),
      itemCount: products.length + (isLoadingMore ? 1 : 0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.6,
      ),
      itemBuilder: (context, index) {
        if (index >= products.length) {
          return const Center(child: CircularProgressIndicator());
        }

        final product = products[index];

        return ProductCard(
          product: product,
          onTap: () {
            context.pushNamed(Routes.productDetailsName, extra: product);
          },
        );
      },
    );
  }
}
