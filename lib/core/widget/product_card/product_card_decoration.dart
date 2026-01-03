import 'package:flutter/material.dart';

class ProductCardDecoration {
  static BoxDecoration build(BuildContext context) {
    return BoxDecoration(
      color: Theme.of(context).colorScheme.onPrimary,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        width: .5,
      ),
      boxShadow: [
        BoxShadow(
          color: Theme.of(context).colorScheme.shadow,
          blurRadius: 6,
          offset: const Offset(0, 3),
        ),
      ],
    );
  }
}
