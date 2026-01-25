import 'package:flowers_app/Features/order/presentation/check_out/widgets/address_tile.dart';
import 'package:flowers_app/Features/order/presentation/check_out/widgets/check_out_section_wrapper.dart';
import 'package:flowers_app/core/constants/app_colors.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

class AddressSection extends StatelessWidget {
  const AddressSection({super.key});

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
          AddressTile(
            title: 'Home',
            address: '2XVX+XC - Sheikh Zayed',
            isSelected: true,
            onTap: () {
              // لاحقًا: vm.selectAddress(home)
            },
            onEdit: () {},
          ),

          const SizedBox(height: 16),
          AddressTile(
            title: 'Office',
            address: '2XVX+XC - Sheikh Zayed',
            isSelected: false,
            onTap: () {
              // لاحقًا: vm.selectAddress(office)
            },
            onEdit: () {},
          ),

          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: Icon(
                Icons.add,
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
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
                foregroundColor: theme.colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
