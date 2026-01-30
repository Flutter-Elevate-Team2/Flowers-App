import 'package:flowers_app/Features/commerce/presentation/home/widgets/shared/address_item_widget.dart';
import 'package:flowers_app/Features/commerce/presentation/home/widgets/shared/empty_address_state_widget.dart';
import 'package:flowers_app/Features/user_address/domain/entities/address_entity.dart';
import 'package:flowers_app/core/app_router/app_router.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flowers_app/core/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
          // === Header ===
          Center(
            child: Container(
              width: 50,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Select Address',
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),

          // === Content Logic ===
          if (addresses.isEmpty) ...[
            const EmptyAddressStateWidget(),
          ] else ...[
            Flexible(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: addresses.length,
                separatorBuilder: (context, index) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final address = addresses[index];
                  final isSelected = selectedAddress?.id == address.id;

                  return AddressItemWidget(
                    address: address,
                    isSelected: isSelected,
                    onTap: () {
                      onAddressSelected(address);
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ],

          const SizedBox(height: 24),

          CustomButton(
            title: context.l10n.addNewAddress,
            onPressed: () {
              context.pop();
              context.pushNamed(Routes.addAddressName).then((_) {});
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
