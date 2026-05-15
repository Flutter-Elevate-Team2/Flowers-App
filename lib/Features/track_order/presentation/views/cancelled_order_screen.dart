import 'package:flowers_app/core/app_router/app_router.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flowers_app/core/widget/custom_button.dart';
import 'package:flowers_app/gen/assets.gen.dart';
 import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CancelledOrderScreen extends StatelessWidget {
  final String orderId;
  const CancelledOrderScreen({required this.orderId, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          child: const Icon(Icons.arrow_back_ios),
          onTap: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Lottie.asset(
                    Assets.lottie.errorAnimation,
                     fit: BoxFit.fill,
                     repeat: false
                  ),
                ),
              ),
              Expanded(
                child:
                Column(
                  children: [
                    Text(
                      context.l10n.orderCancelled,
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      context.l10n.orderHasBeenCancelled,
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    )
                  ],
                )
              ),
               CustomButton(
                title: context.l10n.reorder,
                onPressed: () {
                  context.pushReplacementNamed(Routes.homeName);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
