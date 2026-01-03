import 'package:cached_network_image/cached_network_image.dart';
import 'package:flowers_app/core/constants/app_colors.dart';
import 'package:flowers_app/core/widget/app_shimmer.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final String title;
  final String imageUrl;
  final double boxSize;
  final VoidCallback? onTap;

  const CategoryItem({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.boxSize,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: boxSize,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: boxSize,
            height: boxSize * 0.94,
            decoration: BoxDecoration(
              color: AppColors.lightPink,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onTap,
                borderRadius: BorderRadius.circular(20),
                child: Center(
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    width: boxSize * 0.5,
                    height: boxSize * 0.5,
                    fit: BoxFit.contain,
                    placeholder: (context, url) => AppShimmer(
                      height: boxSize * 0.5,
                      width: boxSize * 0.5,
                      radius: 100,
                    ),
                    errorWidget: (context, url, error) => Icon(
                      Icons.local_florist_outlined,
                      color: AppColors.mainColor,
                      size: boxSize * 0.45,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Flexible(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: (boxSize * 0.18).clamp(12.0, 16.0),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}