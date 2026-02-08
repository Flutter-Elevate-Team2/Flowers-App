import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

class FloatingButtonContent extends StatelessWidget {
  const FloatingButtonContent({super.key});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.filter_list_rounded),
          const SizedBox(width: 4),
          Text(context.l10n.filter),
        ],
      ),
    );
  }
}
