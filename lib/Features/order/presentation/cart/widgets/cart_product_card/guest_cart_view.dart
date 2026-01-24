import 'package:flowers_app/core/constants/app_colors.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flowers_app/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class GuestCartView extends StatelessWidget {
  final VoidCallback onLogin;
  final String? subTitle;

  const GuestCartView({super.key, required this.onLogin, this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              Assets.lottie.login,
              height: MediaQuery.of(context).size.height * 0.3,
              repeat: true,
            ),
            const SizedBox(height: 16),
            Text(
              context.l10n.youAreNotLoggedIn,
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: AppColors.mainColor),
            ),
            const SizedBox(height: 8),
            Text(
              subTitle ?? context.l10n.pleaseLoginToContinue,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: onLogin,
              child: Text(context.l10n.loginButton),
            ),
          ],
        ),
      ),
    );
  }
}
