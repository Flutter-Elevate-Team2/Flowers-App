import 'package:flowers_app/core/constants/app_colors.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EstimatedArrival extends StatelessWidget {
  final DateTime date ;
  const EstimatedArrival({required this.date ,super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.estimatedArrival,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: AppColors.gray.withValues(alpha: 0.6),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            DateFormat(
              'dd MMM yyyy, hh:mm a',
            ).format(date),
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
