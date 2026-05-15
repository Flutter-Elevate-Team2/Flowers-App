import 'package:flowers_app/Features/auth/presentation/forget_password/view_model/forget_password_cubit.dart';
import 'package:flowers_app/Features/auth/presentation/forget_password/view_model/forget_password_intent.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResendCodeText extends StatelessWidget {
  final String? email;
  final bool isLoading;

  const ResendCodeText({
    super.key,
    this.email,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(context.l10n.resendCode, style: Theme.of(context).textTheme.bodyMedium),
        isLoading
            ? const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        )
            : TextButton(
          onPressed: () {
            context.read<ForgetPasswordCubit>().doIntent(
              SendOtp(email: email ?? ''),
            );
          },
          child: Text(
            context.l10n.resend,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).primaryColor,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}