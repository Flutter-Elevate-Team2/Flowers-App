import 'package:flowers_app/Features/order/domain/entities/checkout/address_entity.dart';
import 'package:flowers_app/Features/order/presentation/check_out/widgets/address_tile.dart';
import 'package:flowers_app/Features/order/presentation/check_out/widgets/check_out_section_wrapper.dart';
import 'package:flowers_app/core/constants/app_colors.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

class AddressSection extends StatefulWidget {
  final ValueChanged<AddressEntity> onAddressSelected;

  const AddressSection({super.key, required this.onAddressSelected});

  @override
  State<AddressSection> createState() => _AddressSectionState();
}

class _AddressSectionState extends State<AddressSection> {
  late List<AddressEntity> addresses;
  late AddressEntity selectedAddress;

  @override
  void initState() {
    super.initState();
    addresses = [
      AddressEntity(
        id: "1",
        title: "Home",
        street: "2XVX+XC - Sheikh Zayed",
        city: "Sheikh Zayed",
        phone: "0123456789",
        lat: 30.0,
        long: 31.0,
      ),
      AddressEntity(
        id: "2",
        title: "Office",
        street: "3XVX+XC - Cairo",
        city: "Cairo",
        phone: "01010800921",
        lat: 30.1,
        long: 31.2,
      ),
    ];
    selectedAddress = addresses.first;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onAddressSelected(selectedAddress);
    });
  }

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
                title: address.title,
                address: address.street,
                isSelected: selectedAddress.id == address.id,
                onTap: () {
                  setState(() {
                    selectedAddress = address;
                  });
                  widget.onAddressSelected(selectedAddress);
                },
                onEdit: () {},
              ),
            );
          }),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {},
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
