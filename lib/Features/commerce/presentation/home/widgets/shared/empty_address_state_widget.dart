import 'package:flowers_app/core/constants/app_colors.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

class EmptyAddressStateWidget extends StatelessWidget {
  const EmptyAddressStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          Icon(
            Icons.location_off_outlined,
            size: 60,
            color: AppColors.gray.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 12),
          Text(
            context.l10n.noSavedAddresses,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: AppColors.gray),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
