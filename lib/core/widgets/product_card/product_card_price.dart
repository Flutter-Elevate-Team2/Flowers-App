import 'package:flutter/material.dart';

class ProductCardPrice extends StatelessWidget {
  final num priceAfterDiscount;

  const ProductCardPrice({super.key, required this.priceAfterDiscount});

  @override
  Widget build(BuildContext context) {
    return Text(
      'EGP $priceAfterDiscount',
      style: Theme.of(
        context,
      ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
    );
  }
}