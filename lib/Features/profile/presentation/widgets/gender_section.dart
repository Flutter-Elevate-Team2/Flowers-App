import 'package:flutter/material.dart';

class GenderRadioButton extends StatelessWidget {
  final String label;
  final bool isSelected;

  const GenderRadioButton({
    super.key,
    required this.label,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Radio<bool>(
            value: true,
            groupValue:
                isSelected,
            activeColor: Theme.of(context).colorScheme.primary,
            onChanged: (val) {}, // No-op
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
    );
  }
}
