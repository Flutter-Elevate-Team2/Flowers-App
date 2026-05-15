import 'package:cached_network_image/cached_network_image.dart';
import 'package:flowers_app/core/constants/app_colors.dart';
import 'package:flowers_app/core/widget/app_shimmer.dart';
import 'package:flutter/material.dart';

class ProductCardImage extends StatelessWidget {
  final String imgCover;
  final double height;
  final double radius;
  final double bottomRadius;

  const ProductCardImage({
    super.key,
    required this.imgCover,
    required this.height,
    this.radius = 12,
    this.bottomRadius = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.lightPink,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(radius),
          bottom: Radius.circular(bottomRadius),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(radius),
          bottom: Radius.circular(bottomRadius),
        ),
        child: CachedNetworkImage(
          imageUrl: imgCover,
          fit: BoxFit.cover,
          placeholder: (context, url) => AppShimmer(
            height: double.infinity,
            width: double.infinity,
            radius: radius,
          ),
          errorWidget: (context, url, error) => const Center(
            child: Icon(Icons.image_not_supported_outlined, color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
