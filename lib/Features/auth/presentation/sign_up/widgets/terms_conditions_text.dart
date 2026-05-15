import 'package:flowers_app/core/constants/app_colors.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flowers_app/core/app_router/app_router.dart';

class TermsAndConditionsText extends StatelessWidget {
  const TermsAndConditionsText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          context.l10n.termsConditions,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 12),
        ),
        InkWell(
          onTap: () {
            context.pushNamed(Routes.termsandConditionsName);
          },
          child: Text(
            " ${context.l10n.termsAndConditions}",
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              decoration: TextDecoration.underline,
              decorationColor: AppColors.black,
            ),
          ),
        ),
      ],
    );
  }
}
