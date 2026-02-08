import 'package:flowers_app/Features/order/presentation/check_out/widgets/check_out_section_wrapper.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

class DeliveryTimeSection extends StatelessWidget {
  const DeliveryTimeSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CheckOutSectionWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.l10n.deliveryTime,
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  foregroundColor: theme.colorScheme.primary,
                  textStyle: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                child:  Text(context.l10n.schedule),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.access_time, size: 24, color: Colors.black),
              const SizedBox(width: 6),
              Text(
                context.l10n.instant,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                context.l10n.arriveBy,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: theme.colorScheme.tertiary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
