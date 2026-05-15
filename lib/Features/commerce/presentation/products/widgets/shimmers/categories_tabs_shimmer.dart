import 'package:flutter/material.dart';
import 'package:flowers_app/core/widget/app_shimmer.dart';

class CategoriesTabsShimmer extends StatelessWidget {
  const CategoriesTabsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShimmer(width: 50, height: 18, radius: 12);
  }
}
