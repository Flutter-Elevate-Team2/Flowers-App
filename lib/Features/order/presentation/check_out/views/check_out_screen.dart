import 'package:flowers_app/Features/order/presentation/check_out/view_model/checkout_view_model.dart';
import 'package:flowers_app/Features/order/presentation/check_out/widgets/check_out_body.dart';
import 'package:flowers_app/core/constants/app_colors.dart';
import 'package:flowers_app/core/di/di.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckOutScreen extends StatelessWidget {
  const CheckOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CheckoutViewModel>(),
      child: Scaffold(
        backgroundColor: AppColors.lightGray,
        appBar: AppBar(
          title: Text(
            context.l10n.checkout,
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        body: const CheckOutBody(),
      ),
    );
  }
}
