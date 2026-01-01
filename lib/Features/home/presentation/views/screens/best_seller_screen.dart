import 'package:flowers_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants/assets_manager.dart';
import '../../../../../core/constants/constant_keys.dart';
import '../../widgets/custom_card_flower.dart';

class BestSeller extends StatelessWidget {
  const BestSeller({super.key});

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
      body: GridView.builder(
        
        padding: const EdgeInsets.all(16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          childAspectRatio: 0.7,
        ),
        itemCount: 20,
        itemBuilder: (context, index) {
          return const CustomCardFlower(
            title: ConstKeys.cardtitle,
            oldPrice: 800,
            image: AssetsManager.testPhoto,
            newPrice: 600,
            discount: 20,
          );
        },
      ),
    );
  }
}
