import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

class CustomButtonNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

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
      items: _buildItems(context),
    );
  }

  List<BottomNavigationBarItem> _buildItems(BuildContext context) {
    return [
      _buildItem(
        icon: Icons.home_outlined,
        label: context.l10n.home,
      ),
      _buildItem(
        icon: Icons.category_outlined,
        label: context.l10n.categories,
      ),
      _buildItem(
        icon: Icons.shopping_cart_outlined,
        label: context.l10n.cart,
      ),
      _buildItem(
        icon: Icons.person_outline,
        label: context.l10n.profile,
      ),
    ];
  }

  BottomNavigationBarItem _buildItem({
    required IconData icon,
    required String label,
  }) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: label,
    );
  }
}
