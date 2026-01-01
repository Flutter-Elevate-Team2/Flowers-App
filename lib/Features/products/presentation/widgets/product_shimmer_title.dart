import 'package:flowers_app/core/widget/app_shimmer.dart';
import 'package:flutter/material.dart';

class ProductShimmerTitle extends StatelessWidget {
  const ProductShimmerTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShimmer(
      width: MediaQuery.of(context).size.width * 0.3,
      height: 14,
    );
  }
}
