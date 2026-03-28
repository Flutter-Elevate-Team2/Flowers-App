import 'package:flowers_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CustomMapBackButton extends StatelessWidget {
  const CustomMapBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.mainColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.lightGray.withValues(alpha: 0.2),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(Icons.arrow_back_ios_new, color: AppColors.white, size: 18),
      ),
    );
  }
}
