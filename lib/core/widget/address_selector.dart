import 'package:flowers_app/Features/user_address/domain/entities/address_entity.dart';
import 'package:flowers_app/Features/user_address/presentation/view_model/user_address_state.dart';
import 'package:flowers_app/Features/user_address/presentation/view_model/user_address_view_model.dart';
import 'package:flowers_app/core/constants/app_colors.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flowers_app/core/widget/address_sheet_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddressSelector extends StatefulWidget {
  const AddressSelector({super.key});

  @override
  State<AddressSelector> createState() => _AddressSelectorState();
}

class _AddressSelectorState extends State<AddressSelector> {
  String? selectedAddressId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserAddressViewModel, UserAddressState>(
      buildWhen: (previous, current) =>
          previous.getAddressesState?.data != current.getAddressesState?.data ||
          previous.getAddressesState?.isLoading !=
              current.getAddressesState?.isLoading,
      builder: (context, state) {
        final List<AddressEntity> addresses =
            state.getAddressesState?.data?.addresses ?? [];
        AddressEntity? displayAddress;

        if (addresses.isNotEmpty) {
          if (selectedAddressId != null) {
            try {
              displayAddress = addresses.firstWhere(
                (e) => e.id == selectedAddressId,
              );
            } catch (e) {
              displayAddress = addresses.first;
              selectedAddressId = displayAddress.id;
            }
          } else {
            displayAddress = addresses.first;
          }
        }

        return GestureDetector(
          onTap: () => AddressSheetHelper.show(
            context,
            addresses: addresses,
            currentSelected: displayAddress,
            onAddressSelected: (address) =>
                setState(() => selectedAddressId = address.id),
          ),
          child: Row(
            children: [
              const Icon(Icons.location_on_outlined, size: 16),
              const SizedBox(width: 4),
              Text(
                displayAddress == null ? "${context.l10n.deliverTo} " : "",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Flexible(
                child: Text(
                  displayAddress != null
                      ? "${displayAddress.city}, ${displayAddress.street}"
                      : context.l10n.addNewAddress,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Transform.translate(
                offset: const Offset(0, -3),
                child: RotatedBox(
                  quarterTurns: 3,
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 16,
                    color: AppColors.mainColor,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
