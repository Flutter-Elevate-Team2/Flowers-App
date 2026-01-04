import 'package:flowers_app/Features/commerce/presentation/products/widgets/shimmers/product_shimmer.dart';
import 'package:flutter/material.dart';

class ProductsGridShimmer extends StatelessWidget {
  final ScrollController? controller;
  final int itemCount;
  final bool shrinkWrap;
  final ScrollPhysics? physics;

  const ProductsGridShimmer({
    this.controller,
    this.itemCount = 6,
    this.shrinkWrap = false,
    this.physics,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: controller,
      itemCount: itemCount,
      shrinkWrap: shrinkWrap,
      physics: physics,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.6,
      ),
      itemBuilder: (context, index) {
        return const ProductShimmer();
      },
    );
  }
}
