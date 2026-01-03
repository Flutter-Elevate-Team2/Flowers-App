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
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      child: Image.network(
        imageUrl,
        width: double.infinity,
        height: height,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) =>
            const Icon(Icons.broken_image, size: 50, color: Colors.grey),
      ),
    );
  }
}
