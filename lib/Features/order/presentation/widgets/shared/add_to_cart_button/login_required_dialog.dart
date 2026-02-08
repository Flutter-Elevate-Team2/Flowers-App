import 'package:flowers_app/core/app_router/app_router.dart';
import 'package:flowers_app/core/constants/app_colors.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginRequiredDialog extends StatelessWidget {
  const LoginRequiredDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title
            Text(
              context.l10n.loginRequired,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            // Content
            Text(
              context.l10n.pleaseLoginToAdd,
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: AppColors.gray),
            ),

            const SizedBox(height: 24),

            // Buttons
            Row(
              children: [
                // Cancel button
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      side: BorderSide(color: AppColors.gray),
                      padding: const EdgeInsets.all(20),
                    ),
                    child: Text(
                      context.l10n.cancelDialog,
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: AppColors.black),
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                // Login button
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      context.pushNamed(Routes.signInName);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.mainColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.all(20),
                      elevation: 0,
                    ),
                    child: Text(
                      context.l10n.loginButton,
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: AppColors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
