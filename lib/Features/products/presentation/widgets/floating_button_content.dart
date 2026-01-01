import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

class FloatingButtonContent extends StatelessWidget {
  const FloatingButtonContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Icon(Icons.filter_list_rounded),
        Text(context.l10n.filter),
      ],
    );
  }
}
