import 'package:flowers_app/core/widget/app_shimmer.dart';
import 'package:flutter/material.dart';

class ProductShimmerImage extends StatelessWidget {
  const ProductShimmerImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: AppShimmer(
        width: double.infinity,
        height: double.infinity,
        radius: 16,
      ),
    );
  }
}
