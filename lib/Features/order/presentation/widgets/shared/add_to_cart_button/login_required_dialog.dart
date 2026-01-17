import 'package:flowers_app/core/app_router/app_router.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginRequiredDialog extends StatelessWidget {
  const LoginRequiredDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(context.l10n.loginRequired),
      content: Text(context.l10n.pleaseLoginToAdd),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(context.l10n.cancelDialog),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            context.pushNamed(Routes.signInName);
          },
          child: Text(context.l10n.loginButton),
        ),
      ],
    );
  }
}
