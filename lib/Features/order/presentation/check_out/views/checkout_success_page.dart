import 'package:flowers_app/core/app_router/app_router.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flowers_app/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flowers_app/core/widget/custom_button.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class CheckoutSuccessPage extends StatelessWidget {
  const CheckoutSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  Assets.lottie.paymentSuccess,
                  height: MediaQuery.of(context).size.height * 0.45,
                  repeat: true,
                ),

                Text(
                  context.l10n.thankYou,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.secondary,
                  ),
                ),

                const SizedBox(height: 20),

                Text(
                  context.l10n.placedSuccessfully,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: theme.colorScheme.secondary,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 32),

                CustomButton(
                  title: context.l10n.goToHome,
                  onPressed: () {
                    context.goNamed(Routes.homeName);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
