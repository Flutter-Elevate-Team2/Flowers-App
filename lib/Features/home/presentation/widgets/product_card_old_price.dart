import 'package:flutter/material.dart';

class ProductCardOldPrice extends StatelessWidget {
  final num price;

  const ProductCardOldPrice({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    return Text(
      '$price',
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
        color: Colors.grey,
        decoration: TextDecoration.lineThrough,
      ),
      overflow: TextOverflow.ellipsis,
    );
  }
}