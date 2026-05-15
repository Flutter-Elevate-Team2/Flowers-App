import 'package:flowers_app/Features/user_address/domain/entities/address_entity.dart';
import 'package:flowers_app/core/constants/app_colors.dart';
import 'package:flowers_app/core/theming/app_theming.dart';
import 'package:flutter/material.dart';

class AddressItemWidget extends StatelessWidget {
  final AddressEntity address;
  final bool isSelected;
  final VoidCallback onTap;

  const AddressItemWidget({
    super.key,
    required this.address,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
      leading: CircleAvatar(
        backgroundColor: isSelected
            ? AppColors.mainColor.withValues(alpha: 0.1)
            : Colors.grey.withValues(alpha: 0.1),
        child: Icon(
          Icons.location_on_outlined,
          color: isSelected ? AppColors.mainColor : AppColors.gray,
          size: 20,
        ),
      ),
      title: Text(
        address.city,
        style: AppTheme.getTextStyle(
          fontSize: 16,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          color: isSelected ? AppColors.mainColor : AppColors.black,
        ),
      ),
      subtitle: Text(
        "${address.street} - ${address.phone}",
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: AppTheme.getTextStyle(fontSize: 12, color: AppColors.gray),
      ),
      trailing: isSelected
          ? Icon(Icons.check_circle, color: AppColors.mainColor)
          : null,
      onTap: onTap,
    );
  }
}
