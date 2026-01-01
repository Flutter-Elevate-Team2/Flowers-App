import 'package:flowers_app/Features/products/presentation/widgets/sort_option.dart';
import 'package:flutter/material.dart';

class SortByItem extends StatelessWidget {
  final String label;
  final SortOption option;
  final SortOption? selectedOption;
  final ValueChanged<SortOption> onTap;

  const SortByItem({
    super.key,
    required this.label,
    required this.option,
    required this.selectedOption,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(option),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onPrimary,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.secondary.withOpacity(
                0.12,
              ), // Adjusted alpha to opacity roughly
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ListTile(
          title: Text(label, style: Theme.of(context).textTheme.headlineMedium),
          trailing: Radio<SortOption>(
            value: option,
            groupValue: selectedOption,
            activeColor: Theme.of(context).colorScheme.primary,
            onChanged: (value) {
              if (value != null) {
                onTap(value);
              }
            },
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        ),
      ),
    );
  }
}
