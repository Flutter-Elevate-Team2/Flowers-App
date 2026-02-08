import 'package:flowers_app/Features/commerce/presentation/home/widgets/sections/address_selection_bottom_sheet.dart';
import 'package:flowers_app/Features/user_address/domain/entities/address_entity.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

class AddressSheetHelper {
  static void show(
    BuildContext context, {
    required List<AddressEntity> addresses,
    required AddressEntity? currentSelected,
    required Function(AddressEntity) onAddressSelected,
  }) {
    if (addresses.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.noSavedAddresses)),
      );
      return;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => AddressSelectionBottomSheet(
        addresses: addresses,
        selectedAddress: currentSelected,
        onAddressSelected: onAddressSelected,
      ),
    );
  }
}
