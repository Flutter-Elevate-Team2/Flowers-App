import 'package:flowers_app/core/constants/app_colors.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TermsAndConditionsText extends StatelessWidget {
  const TermsAndConditionsText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            // Make sure your arb file has the full text split correctly or use one string here
            text: "${context.l10n.termsConditions} ",
            style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 12),
          ),
          TextSpan(
            text: "Terms & Conditions", // Or add a specific key for this in arb
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.black,
                ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                // TODO: Navigate to Terms screen
              },
          ),
        ],
      ),
    );
  }
}
