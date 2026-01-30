import 'package:flowers_app/Features/user_address/domain/entities/address_entity.dart';
import 'package:flowers_app/Features/user_address/presentation/view_model/user_address_event.dart';
import 'package:flowers_app/Features/user_address/presentation/view_model/user_address_state.dart';
import 'package:flowers_app/Features/user_address/presentation/view_model/user_address_view_model.dart';
import 'package:flowers_app/core/app_router/app_router.dart';
import 'package:flowers_app/core/constants/app_colors.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flowers_app/core/widget/address_sheet_helper.dart';
import 'package:flowers_app/core/widget/selected_address_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddressSelector extends StatelessWidget {
  const AddressSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectedAddressCubit, AddressEntity?>(builder: (context, selectedAddress) {
      return BlocBuilder<UserAddressViewModel, UserAddressState>(
        buildWhen: (previous, current) =>
        previous.getAddressesState?.data != current.getAddressesState?.data ||
            previous.getAddressesState?.isLoading != current.getAddressesState?.isLoading,
        builder: (context, state) {
          final bool isLoading = state.getAddressesState?.isLoading ?? false;
          final List<AddressEntity> addresses = state.getAddressesState?.data?.addresses ?? [];

          /// نحدد العنوان اللي هيتعرض
          final AddressEntity? displayAddress =
              selectedAddress ?? (addresses.isNotEmpty ? addresses.first : null);

          /// نص العرض حسب الحالة
          String displayText;
          if (isLoading) {
            displayText = "Loading…";
          } else if (addresses.isEmpty) {
            displayText = context.l10n.addNewAddress;
          } else if (displayAddress != null) {
            displayText = "${displayAddress.city}, ${displayAddress.street}";
          } else {
            displayText = context.l10n.addNewAddress;
          }

          return GestureDetector(
            onTap: () {
              if (addresses.isEmpty) {
                // لو مفيش أي عنوان، نروح مباشرة على صفحة Add Address
                Navigator.pushNamed(context, Routes.addAddressName).then((result) {
                  // لو أضافت عنوان جديد، نعمل تحديث للعناوين
                  if (result == true && context.mounted) {
                    context.read<UserAddressViewModel>().doIntent(GetAddressesEvent());
                  }
                });
              } else {
                // لو فيه عناوين، نعرض الـ AddressSheet
                AddressSheetHelper.show(
                  context,
                  addresses: addresses,
                  currentSelected: displayAddress,
                  onAddressSelected: (address) {
                    context.read<SelectedAddressCubit>().select(address);
                  },
                );
              }
            },
            child: Row(
              children: [
                const Icon(Icons.location_on_outlined, size: 16),
                const SizedBox(width: 4),
                Text(
                  "${context.l10n.deliverTo} ",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Flexible(
                  child: Text(
                    displayText,
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
    });
  }
}

