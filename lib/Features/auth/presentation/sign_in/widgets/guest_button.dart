import 'package:flowers_app/core/constants/app_colors.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

class GuestButton extends StatelessWidget {
  final VoidCallback onPressed;

  const GuestButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: SizedBox(
        width: double.infinity,
        height: 48,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.white,
            foregroundColor: AppColors.gray,
            side: BorderSide(color: AppColors.gray, width: 1),
          ),
          onPressed: onPressed,
          child: Text((context).l10n.guestLogin),
        ),
      ),
    );
  }
}
