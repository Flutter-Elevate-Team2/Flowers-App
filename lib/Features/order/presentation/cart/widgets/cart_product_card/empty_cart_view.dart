import 'package:flowers_app/core/constants/app_colors.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flowers_app/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyCartView extends StatelessWidget {
  const EmptyCartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              Assets.lottie.emptyCart,
              height: MediaQuery.of(context).size.height * 0.3,
              repeat: true,
            ),
            const SizedBox(height: 16),
            Text(
              context.l10n.yourCartIsEmpty,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.mainColor
              ),
            ),
            const SizedBox(height: 8),
            Text(
              context.l10n.addSomeFlowers,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
