import 'package:flowers_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final double boxSize;

  const CategoryItem({
    super.key,
    required this.title,
    required this.icon,
    required this.boxSize,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: boxSize,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: boxSize,
            height: boxSize * 0.94,
            decoration: BoxDecoration(
              color: AppColors.lightPink,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Icon(
                  icon,
                  color: AppColors.mainColor,
                  size: boxSize * 0.45,
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Flexible(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: (boxSize * 0.18).clamp(12.0, 16.0),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
