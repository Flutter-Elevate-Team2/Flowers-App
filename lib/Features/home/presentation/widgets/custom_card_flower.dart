import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class CustomCardFlower extends StatelessWidget {
  const CustomCardFlower({
    super.key,
    required this.image,
    required this.title,
    required this.newPrice,
    this.oldPrice,
    this.discount,
  });
  final String image;
  final String title;
  final double newPrice;
  final double? oldPrice;
  final int? discount;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 163.0,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(width: 1.0, color: AppColors.gray),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            imageUrl: image,
            width: 147.0,
            height: 131.0,
            fit: BoxFit.cover,
            placeholder: (context, _) => const CircularProgressIndicator(),
            errorWidget: (context, _, error) => const Center(
              child: Icon(
                Icons.image_not_supported_rounded,
                color: AppColors.gray,
                size: 24.0,
              ),
            ),
          ),
          const SizedBox(height: 5.0),
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.black[60],
              fontSize: 12.0,
            ),
          ),
          const SizedBox(height: 5.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "EGP $newPrice ",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.black[60],
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "$oldPrice",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.black[60],
                  fontSize: 12.0,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              Text(
                "$discount%",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.green,
                  fontSize: 12.0,
                ),
              ),
            ],
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(CupertinoIcons.cart, color: Colors.white),
                const SizedBox(width: 7.0),
                Text(
                  "Add to Cart",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                    fontSize: 13.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
