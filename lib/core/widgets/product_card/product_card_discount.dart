import 'package:flutter/material.dart';

class ProductCardDiscount extends StatelessWidget {
  final int discount;

  const ProductCardDiscount({super.key, required this.discount});

  @override
  Widget build(BuildContext context) {
    return Text(
      '$discount%',
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
        color: Theme.of(context).colorScheme.tertiary,
      ),
      overflow: TextOverflow.ellipsis,
    );
  }
}