import 'package:flowers_app/Features/user_address/domain/entities/address_entity.dart';
import 'package:flowers_app/core/constants/app_colors.dart';
import 'package:flowers_app/core/theming/app_theming.dart';
import 'package:flutter/material.dart';

class AddressSelectionBottomSheet extends StatelessWidget {
  final List<AddressEntity> addresses;
  final AddressEntity? selectedAddress;
  final Function(AddressEntity) onAddressSelected;

  const AddressSelectionBottomSheet({
    super.key,
    required this.addresses,
    required this.selectedAddress,
    required this.onAddressSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select Address',
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: addresses.length,
              itemBuilder: (context, index) {
                final address = addresses[index];
                final isSelected = selectedAddress?.id == address.id;

                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  leading: Icon(
                    Icons.location_on_outlined,
                    color: isSelected ? AppColors.mainColor : AppColors.gray,
                  ),
                  title: Text(
                    address.city,
                    style: AppTheme.getTextStyle(
                      fontSize: 16,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.w400,
                      color: isSelected ? AppColors.mainColor : AppColors.black,
                    ),
                  ),
                  subtitle: Text(
                    address.street,
                    style: AppTheme.getTextStyle(
                      fontSize: 14,
                      color: AppColors.gray,
                    ),
                  ),
                  trailing: isSelected
                      ? Icon(Icons.check_circle, color: AppColors.mainColor)
                      : null,
                  onTap: () {
                    onAddressSelected(address);
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
