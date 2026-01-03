import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

class ProductSearchField extends StatelessWidget {
  final TextEditingController searchController;
  final ValueChanged<String>? onSubmitted;

  const ProductSearchField({
    super.key,
    required this.searchController,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: searchController,
      onSubmitted: onSubmitted,
      decoration: InputDecoration(
        hintText: context.l10n.searchHint,
        prefixIcon: const Icon(Icons.search),
        contentPadding: const EdgeInsets.symmetric(vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Theme.of(
              context,
            ).colorScheme.surfaceContainerHighest.withValues(alpha: 0.4),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Theme.of(
              context,
            ).colorScheme.surfaceContainerHighest.withValues(alpha: 0.4),
          ),
        ),
      ),
    );
  }
}
