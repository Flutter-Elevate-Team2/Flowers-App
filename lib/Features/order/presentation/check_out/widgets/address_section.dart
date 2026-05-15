import 'package:flowers_app/Features/user_address/domain/entities/address_entity.dart';
import 'package:flowers_app/Features/order/presentation/check_out/widgets/address_tile.dart';
import 'package:flowers_app/Features/order/presentation/check_out/widgets/check_out_section_wrapper.dart';
import 'package:flowers_app/core/constants/app_colors.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

class AddressSection extends StatelessWidget {
  final List<AddressEntity> addresses;
  final AddressEntity? selectedAddress;
  final ValueChanged<AddressEntity> onAddressSelected;
  final VoidCallback onAdd;
  final ValueChanged<AddressEntity> onEdit;

  const AddressSection({
    super.key,
    required this.onAddressSelected,
    required this.onAdd,
    required this.onEdit,
    this.addresses = const [],
    this.selectedAddress,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CheckOutSectionWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.deliveryAddress,
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),

          ...addresses.map((address) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: AddressTile(
                city: address.city,
                title: address.username,
                address: address.street,
                isSelected: selectedAddress?.id == address.id,
                onTap: () => onAddressSelected(address),
                onEdit: () => onEdit(address),
              ),
            );
          }),

          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: onAdd,
              icon: Icon(Icons.add, color: theme.colorScheme.primary),
              label: Text(
                context.l10n.addNew,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: AppColors.white[70]!),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
