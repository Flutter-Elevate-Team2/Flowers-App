import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

class AddToCartButton extends StatelessWidget {
  final BoxConstraints constraints;
  final VoidCallback? onPressed;

  const AddToCartButton({super.key, required this.constraints, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: constraints.maxHeight * 0.14,
      child: ElevatedButton.icon(
        onPressed: onPressed ?? () {},
        icon: const Icon(Icons.shopping_cart_outlined),
        label: Text(context.l10n.addToCart),
        style: ElevatedButton.styleFrom(
          textStyle: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
