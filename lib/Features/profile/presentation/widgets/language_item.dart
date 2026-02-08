import 'package:flutter/material.dart';

class LanguageItem extends StatelessWidget {
  const LanguageItem({super.key, required this.language, required this.isSelected});
   final String language;
   final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: isSelected
              ? Theme.of(context).colorScheme.primary
              : Theme.of(
                  context,
                ).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Text(
            language,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          const Spacer(),
          if (isSelected)
            Icon(
              Icons.radio_button_checked,
              color: Theme.of(context).colorScheme.primary,
            )
          else
            Icon(
              Icons.radio_button_off,
              color: Theme.of(context).colorScheme.secondary,
            ),
        ],
      ),
    );
  }
}
