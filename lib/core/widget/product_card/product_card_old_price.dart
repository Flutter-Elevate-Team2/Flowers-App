import 'package:flutter/material.dart';

class ProductCardOldPrice extends StatelessWidget {
  final num price;

  const ProductCardOldPrice({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Text(
        '$price',
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          decoration: TextDecoration.lineThrough,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
