import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

class OccasionDescription extends StatelessWidget {
  const OccasionDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(
        context.l10n.occasionDescription,
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }
}
