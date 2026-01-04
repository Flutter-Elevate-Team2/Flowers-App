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
    return Text(
      title.split(' ').take(3).join(' '),
      style: Theme.of(context).textTheme.bodySmall,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
