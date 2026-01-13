import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

class SortTitle extends StatelessWidget {
  const SortTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      context.l10n.sort,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
