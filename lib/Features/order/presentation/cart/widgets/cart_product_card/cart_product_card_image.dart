import 'package:cached_network_image/cached_network_image.dart';
import 'package:flowers_app/core/constants/app_colors.dart';
import 'package:flowers_app/core/widget/app_shimmer.dart';
import 'package:flutter/material.dart';

class CartProductCardImage extends StatelessWidget {
  final String imgCover;
  final double height;

  const CartProductCardImage({
    super.key,
    required this.imgCover,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.lightPink,
        borderRadius: BorderRadius.all( Radius.circular(12)),
      ),
      child:
        CachedNetworkImage(
          imageUrl: imgCover,
          fit: BoxFit.cover,
          placeholder: (context, url) => AppShimmer(
            height: double.infinity,
            width: double.infinity,
            radius: 12,
          ),
          errorWidget: (context, url, error) => const Center(
            child: Icon(Icons.image_not_supported_outlined, color: Colors.grey),
          ),
        ),
    );
  }
}
