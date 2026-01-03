import 'package:flowers_app/core/widget/app_shimmer.dart';
import 'package:flutter/material.dart';

class ProductShimmerPrice extends StatelessWidget {
  const ProductShimmerPrice({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppShimmer(width: 60, height: 14),
        AppShimmer(width: 40, height: 14),
        AppShimmer(width: 30, height: 14),
      ],
    );
  }
}
