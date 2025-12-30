import 'package:flowers_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class OccasionItem extends StatelessWidget {
  final String title;
  final String? imageUrl;
  final double width;

  const OccasionItem({
    super.key,
    required this.title,
    this.imageUrl,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.gray.withAlpha(50),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.cake,
                color: AppColors.white,
                size: width * 0.25,
              ),
            ),
          ),

          const SizedBox(height: 8),

          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: (width * 0.1).clamp(12.0, 16.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
