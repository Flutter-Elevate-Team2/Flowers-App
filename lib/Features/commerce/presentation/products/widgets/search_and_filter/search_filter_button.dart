import 'package:flutter/material.dart';

class SearchFilterButton extends StatelessWidget {
  final VoidCallback onFilterTap;

  const SearchFilterButton({super.key, required this.onFilterTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: onFilterTap,
        child: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Theme.of(
                context,
              ).colorScheme.surfaceContainerHighest.withValues(alpha: 0.4),
            ),
          ),
          child: const Icon(Icons.filter_list_outlined),
        ),
      ),
    );
  }
}
