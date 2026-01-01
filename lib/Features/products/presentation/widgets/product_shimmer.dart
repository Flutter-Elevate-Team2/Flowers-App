import 'package:flowers_app/core/widget/app_shimmer.dart';
import 'package:flutter/material.dart';

class ProductShimmer extends StatelessWidget {
  const ProductShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _buildContainerBoxDecoration(context),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: _buildProductShimmer(context),
      ),
    );
  }

  Column _buildProductShimmer(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildImageShimmer(),
        const SizedBox(height: 8),
        AppShimmer(width: double.infinity, height: 14),
        const SizedBox(height: 6),
        _buildTitleShimmer(context),
        const SizedBox(height: 10),
        _buildPriceShimmer(),

        const Spacer(),
        AppShimmer(width: double.infinity, height: 36, radius: 8),
      ],
    );
  }

  Expanded _buildImageShimmer() {
    return Expanded(
      flex: 3,
      child: AppShimmer(
        width: double.infinity,
        height: double.infinity,
        radius: 16,
      ),
    );
  }

  AppShimmer _buildTitleShimmer(BuildContext context) {
    return AppShimmer(
      width: MediaQuery.of(context).size.width * 0.3,
      height: 14,
    );
  }

  Row _buildPriceShimmer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppShimmer(width: 60, height: 14),
        AppShimmer(width: 40, height: 14),
        AppShimmer(width: 30, height: 14),
      ],
    );
  }

  BoxDecoration _buildContainerBoxDecoration(BuildContext context) {
    return BoxDecoration(
      color: Theme.of(context).colorScheme.onPrimary,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        width: .5,
      ),
      boxShadow: [
        BoxShadow(
          color: Theme.of(context).colorScheme.shadow,
          blurRadius: 6,
          offset: const Offset(0, 3),
        ),
      ],
    );
  }
}
