import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

class ResendCodeText extends StatelessWidget {
  const ResendCodeText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(context.l10n.resendCode,style: Theme.of(context).textTheme.bodyMedium),
        TextButton(
          
          onPressed: () {
            // Handle resend code action
          },
          child: Text(context.l10n.resend,style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).primaryColor,
            decoration: TextDecoration.underline,
            
          ),),
        ),


      ],
    );
  }
}
