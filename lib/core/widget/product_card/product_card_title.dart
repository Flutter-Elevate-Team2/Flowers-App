import 'package:flutter/material.dart';

class ProductCardTitle extends StatelessWidget {
  final String title;
  final double screenWidth;

  const ProductCardTitle({
    super.key,
    required this.title,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
      child: Text(
        title.split(' ').take(3).join(' '),
        style: Theme.of(context).textTheme.bodySmall,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
