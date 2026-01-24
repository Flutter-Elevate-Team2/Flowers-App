import 'package:flowers_app/core/constants/app_colors.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flowers_app/core/widget/price_formatter.dart';
import 'package:flutter/material.dart';

class TotalPrice extends StatelessWidget {
  final int subTotal;
  final int deliveryFee;
  final int totalPrice;
  final String? locale;

  const TotalPrice({
    required this.subTotal,
    required this.deliveryFee,
    required this.totalPrice,
    required this.locale,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              context.l10n.subtotal,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              PriceFormatter.formatPrice(subTotal , locale: locale),
              style: Theme.of(context).textTheme.titleMedium,
            ),
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
              PriceFormatter.formatPrice(deliveryFee, locale: locale),
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
        Divider(height: 20, thickness: 1, color: AppColors.gray),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              context.l10n.total,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              PriceFormatter.formatPrice(totalPrice, locale: locale),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ],
    );
  }
}
