import 'package:cached_network_image/cached_network_image.dart';
import 'package:flowers_app/core/constants/app_colors.dart';
import 'package:flowers_app/core/widget/app_shimmer.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final String name;
  final String price;
  final String? imageUrl;
  final double width;

  const ProductItem({
    super.key,
    required this.name,
    required this.price,
    this.imageUrl,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1.0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: imageUrl != null && imageUrl!.isNotEmpty
                    ? CachedNetworkImage(
                  imageUrl: imageUrl!,
                  fit: BoxFit.cover,

                  placeholder: (context, url) => const AppShimmer(
                    height: double.infinity,
                    width: double.infinity,
                    radius: 0,
                  ),

                  errorWidget: (context, url, error) => Icon(
                    Icons.image_not_supported_outlined,
                    size: width * 0.35,
                    color: AppColors.gray.withAlpha(100),
                  ),
                )
                    : Center(
                  child: Icon(
                    Icons.image,
                    size: width * 0.35,
                    color: AppColors.gray.withAlpha(100),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: (width * 0.11).clamp(14.0, 18.0),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "$price EGP",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: (width * 0.11).clamp(14.0, 18.0),
                  color: AppColors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}