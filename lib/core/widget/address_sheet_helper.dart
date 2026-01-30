import 'package:flowers_app/Features/commerce/presentation/home/widgets/shared/address_selection_bottom_sheet.dart';
import 'package:flowers_app/Features/user_address/domain/entities/address_entity.dart';
import 'package:flutter/material.dart';

class AddressSheetHelper {
  static void show(
    BuildContext context, {
    required List<AddressEntity> addresses,
    required AddressEntity? currentSelected,
    required Function(AddressEntity) onAddressSelected,
  }) {
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
