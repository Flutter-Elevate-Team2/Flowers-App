import 'package:flowers_app/core/constants/app_colors.dart';
import 'package:flowers_app/gen/fonts.gen.dart';
import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final String hintText;
  final VoidCallback? onTap;

  const CustomSearchBar({super.key, required this.hintText, this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: TextField(
        textAlignVertical: TextAlignVertical.center,
        onTap: onTap,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppColors.gray,
            fontFamily: FontFamily.inter,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
          prefixIcon: const Icon(Icons.search, color: AppColors.gray, size: 24),
          fillColor: AppColors.white,
          filled: true,
          contentPadding: EdgeInsets.zero,
          border: _buildBorder(AppColors.gray),
          enabledBorder: _buildBorder(AppColors.gray),
          focusedBorder: _buildBorder(AppColors.mainColor),
        ),
      ),
    );
  }

  OutlineInputBorder _buildBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: color),
    );
  }
}
