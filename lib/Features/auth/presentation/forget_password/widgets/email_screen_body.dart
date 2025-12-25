import 'package:flowers_app/Features/auth/presentation/forget_password/widgets/custom_text_section.dart';
import 'package:flowers_app/Features/auth/presentation/forget_password/widgets/email_form_section.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

class EmailScreenBody extends StatelessWidget {
  const EmailScreenBody({super.key, required this.onNextPage});

  final VoidCallback onNextPage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          SizedBox(height: 40),
          TextSection(
            tittle: context.l10n.forgotPasswordTitle,
            subTitle: context.l10n.forgotPasswordSubTitle,
          ),
          SizedBox(height: 32),
          EmailFormSection(onNextPage: onNextPage),
        ],
      ),
    );
  }
}
