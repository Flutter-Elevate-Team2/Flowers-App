import 'package:flowers_app/Features/order/presentation/check_out/widgets/radio_indector.dart';
import 'package:flowers_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class AddressTile extends StatelessWidget {
  final String title;
  final String address;
  final bool isSelected;
  final VoidCallback onEdit;
  final VoidCallback onTap;

  const AddressTile({
    super.key,
    required this.title,
    required this.address,
    required this.isSelected,
    required this.onEdit,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: AppColors.white[70]!,
              blurRadius: 4,
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      RadioIndicator(selected: isSelected),
                      const SizedBox(width: 8),
                      Text(
                        title,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    address,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.secondary,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: onEdit,
              icon: Icon(Icons.edit, color: AppColors.gray),
            ),
          ],
        ),
      ),
    );
  }
}
