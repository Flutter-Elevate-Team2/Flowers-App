import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

class RememberMeRow extends StatelessWidget {
  final bool rememberMe;
  final ValueChanged<bool?> onChanged;
  final VoidCallback onForgotPassword;

  const RememberMeRow({
    super.key,
    required this.rememberMe,
    required this.onChanged,
    required this.onForgotPassword,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(value: rememberMe, onChanged: onChanged),
        Text(
          context.l10n.rememberMe,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const Spacer(),
        TextButton(
          onPressed: onForgotPassword,
          child: Text(context.l10n.forgotPasswordLink),
        ),
      ],
    );
  }
}
