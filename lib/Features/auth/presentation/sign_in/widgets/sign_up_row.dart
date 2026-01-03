import 'package:flowers_app/core/app_router/app_router.dart';
import 'package:flowers_app/core/constants/app_colors.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignUpRow extends StatelessWidget {
  const SignUpRow({super.key});

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          (context).l10n.noAccountSignUp,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        TextButton(
          onPressed: () {
            context.push(Routes.signUpPath);
          },
          style:  TextButton.styleFrom(
            foregroundColor: AppColors.mainColor,
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              decoration: TextDecoration.underline,
            ),
          ),
          child: Text(context.l10n.signUpTitle),
        ),
      ],
    );
  }
}