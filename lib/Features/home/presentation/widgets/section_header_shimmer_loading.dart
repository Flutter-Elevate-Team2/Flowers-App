import 'package:flowers_app/core/widgets/app_shimmer.dart';
import 'package:flutter/material.dart';

class SectionHeaderShimmerLoading extends StatelessWidget {
  const SectionHeaderShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppShimmer(width: 100, height: 16),
        AppShimmer(width: 40, height: 12),
      ],
    );
  }
}
