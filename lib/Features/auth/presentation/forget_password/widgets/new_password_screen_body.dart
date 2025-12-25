import 'package:flowers_app/Features/auth/presentation/forget_password/widgets/custom_text_section.dart';
import 'package:flowers_app/Features/auth/presentation/forget_password/widgets/new_password_form.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

class NewPasswordScreenBody extends StatelessWidget {
  const NewPasswordScreenBody({super.key, this.userEmail});

  final String? userEmail;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(height: 40),
          TextSection(
            tittle: context.l10n.resetPasswordTitle,
            subTitle: context.l10n.resetPasswordSubTitle,
          ),
          const SizedBox(height: 32),
          NewPasswordForm(userEmail: userEmail),
        ],
      ),
    );
  }
}
