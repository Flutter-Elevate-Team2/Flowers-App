import 'package:flowers_app/Features/products/presentation/widgets/shimmers/product_shimmer_image.dart';
import 'package:flowers_app/Features/products/presentation/widgets/shimmers/product_shimmer_price.dart';
import 'package:flowers_app/Features/products/presentation/widgets/shimmers/product_shimmer_title.dart';
import 'package:flowers_app/core/widget/app_shimmer.dart';
import 'package:flutter/material.dart';

class ProductShimmerBody extends StatelessWidget {
  const ProductShimmerBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ProductShimmerImage(),
        const SizedBox(height: 8),
        AppShimmer(width: double.infinity, height: 14),
        const SizedBox(height: 6),
        const ProductShimmerTitle(),
        const SizedBox(height: 10),
        const ProductShimmerPrice(),
        const Spacer(),
        AppShimmer(width: double.infinity, height: 36, radius: 8),
      ],
    );
  }
}
