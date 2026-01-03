import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

class FilterActionButton extends StatelessWidget {
  final VoidCallback onPressed;

  const FilterActionButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: const Icon(Icons.filter_list_outlined),
        label: Text(context.l10n.filter),
      ),
    );
  }
}
