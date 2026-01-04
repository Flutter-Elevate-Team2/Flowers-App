import 'package:cached_network_image/cached_network_image.dart';
import 'package:flowers_app/core/widget/app_shimmer.dart';
import 'package:flutter/material.dart';

class ProductCardImage extends StatelessWidget {
  final String imageUrl;
  final double height;

  const ProductCardImage({
    super.key,
    required this.imageUrl,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          width: double.infinity,
          height: height,
          fit: BoxFit.cover,
          placeholder: (context, url) => const AppShimmer(
            height: double.infinity,
            width: double.infinity,
            radius: 0,
          ),
          errorWidget: (context, url, error) => Icon(
            Icons.image_not_supported_outlined,
            size: double.infinity,
            color: Colors.grey.withAlpha(100),
          ),
        ),
      ),
    );
  }
}
