import 'package:flowers_app/core/constants/app_colors.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

class CustomButtonNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomButtonNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.mainColor,
      unselectedItemColor:  AppColors.white.shade800,
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.home_outlined),
          label: (context).l10n.home,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.category_outlined),
          label: (context).l10n.categories,
        ),
         BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart_outlined),
          label: (context).l10n.cart,
        ),
         BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: (context).l10n.profile,
        ),
      ],
    );
  }
}