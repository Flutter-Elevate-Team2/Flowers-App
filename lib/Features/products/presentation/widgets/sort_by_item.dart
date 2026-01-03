import 'package:flowers_app/Features/products/presentation/widgets/sort_option.dart';
import 'package:flutter/material.dart';


class SortByItem extends StatelessWidget {
  final String label;
  final SortOption option;

  const SortByItem({
    super.key,
    required this.label,
    required this.option,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context)
                .colorScheme
                .secondary
                .withAlpha(12),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: RadioListTile<SortOption>(
        title: Text(
          label,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        value: option,
        activeColor: Theme.of(context).colorScheme.primary,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}