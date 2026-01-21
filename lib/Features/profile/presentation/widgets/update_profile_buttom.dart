import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

class UpdateProfileButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const UpdateProfileButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          context.l10n.update,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }
}
