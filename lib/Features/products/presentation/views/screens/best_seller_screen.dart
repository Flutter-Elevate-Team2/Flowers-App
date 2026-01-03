
import 'package:flowers_app/Features/products/presentation/widgets/best_seller_page.dart';
import 'package:flowers_app/core/constants/app_colors.dart';
import 'package:flowers_app/core/constants/constant_keys.dart';
import 'package:flutter/material.dart';


class BestSellerScreen extends StatelessWidget {
  // final List<OccasionEntity>? bestSellers;
  // final int initialIndex;
  const BestSellerScreen({
    super.key,
    // this.bestSellers,
    // this.initialIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              ConstKeys.bestseller,
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              ConstKeys.bestseller2,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: AppColors.gray),
            ),
          ],
        ),
        centerTitle: false,
      ),
      body:BestSellerPage()

    );
  }
}
