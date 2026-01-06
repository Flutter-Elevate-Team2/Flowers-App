import 'package:flowers_app/Features/commerce/presentation/products/widgets/shimmers/product_shimmer_body.dart';
import 'package:flowers_app/Features/commerce/presentation/products/widgets/shimmers/product_shimmer_decoration.dart';
import 'package:flutter/material.dart';

class ProductShimmer extends StatelessWidget {
  const ProductShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ProductShimmerDecoration.build(context),
      child: const Padding(
        padding: EdgeInsets.all(8),
        child: ProductShimmerBody(),
      ),
    );
  }
}
