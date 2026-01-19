import 'package:flutter/material.dart';

class GenderRadioButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback? onTap;

  const GenderRadioButton({
    super.key,
    required this.label,
    required this.isSelected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          SizedBox(
            width: 24,
            height: 24,
            child: Radio<bool>(
              value: true,
              groupValue: isSelected,
              activeColor: Theme.of(context).colorScheme.primary,
              onChanged: onTap != null ? (_) => onTap!() : null,
              visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: isSelected
                  ? Theme.of(context).colorScheme.secondary
                  : Theme.of(context).colorScheme.surfaceContainerHighest,
            ),
          ),
        ],
      ),
    );
  }
}
