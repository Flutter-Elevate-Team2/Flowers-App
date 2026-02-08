import 'package:flowers_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

enum PaymentMethod { cash, creditCard }

class PaymentMethodOption extends StatelessWidget {
  final String title;
  final PaymentMethod value;

  const PaymentMethodOption({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        RadioGroup.maybeOf<PaymentMethod>(context)?.onChanged(value);
      },
      child: Container(
        margin: const EdgeInsets.only(top: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [BoxShadow(color: AppColors.white[70]!, blurRadius: 4)],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            Radio<PaymentMethod>(
              value: value,
              activeColor: theme.colorScheme.primary,
            ),
          ],
        ),
      ),
    );
  }
}
