import 'package:flowers_app/Features/order/presentation/check_out/widgets/check_out_section_wrapper.dart';
import 'package:flowers_app/Features/order/presentation/check_out/widgets/payment_method_option.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

class PaymentMethodSection extends StatelessWidget {
  final PaymentMethod selectedMethod;
  final ValueChanged<PaymentMethod> onChanged;

  const PaymentMethodSection({
    super.key,
    required this.selectedMethod,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CheckOutSectionWrapper(
      child: RadioGroup<PaymentMethod>(
        groupValue: selectedMethod,
        onChanged: (value) {
          if (value != null) {
            onChanged(value);
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.l10n.paymentMethod,
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            PaymentMethodOption(
              title: context.l10n.cashOnDelivery,
              value: PaymentMethod.cash,
            ),
            PaymentMethodOption(
              title: context.l10n.creditCard,
              value: PaymentMethod.creditCard,
            ),
          ],
        ),
      ),
    );
  }
}
