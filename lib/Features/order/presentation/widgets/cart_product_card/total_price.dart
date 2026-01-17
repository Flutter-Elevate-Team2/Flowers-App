import 'package:flowers_app/core/constants/app_colors.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

class TotalPrice extends StatelessWidget {
  final int? totalPrice ;
  const TotalPrice({this.totalPrice ,super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(context.l10n.subtotal, style: Theme.of(context).textTheme.titleMedium),
            Text('$totalPrice\$', style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              context.l10n.deliveryFee,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              '10\$',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
        Divider(height: 20, thickness: 1, color: AppColors.gray),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(context.l10n.total, style: Theme.of(context).textTheme.headlineMedium),
            Text('${totalPrice! + 10  }\$', style: Theme.of(context).textTheme.headlineMedium),
          ],
        ),
      ],
    );
  }
}
