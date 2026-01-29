import 'package:flowers_app/Features/commerce/presentation/home/widgets/sections/address_selection_bottom_sheet.dart';
import 'package:flowers_app/Features/commerce/presentation/home/widgets/shared/custom_search_bar.dart';
import 'package:flowers_app/Features/user_address/domain/entities/address_entity.dart';
import 'package:flowers_app/Features/user_address/presentation/view_model/user_address_state.dart';
import 'package:flowers_app/Features/user_address/presentation/view_model/user_address_view_model.dart';
import 'package:flowers_app/core/constants/app_colors.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flowers_app/gen/assets.gen.dart';
import 'package:flowers_app/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({super.key});

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
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
                (element) => element.id == selectedAddressId,
              );
            } catch (e) {
              displayAddress = addresses.first;
              selectedAddressId = displayAddress.id;
            }
          } else {
            displayAddress = addresses.first;
          }
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // === Top Row: Logo + Search Bar ===
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  Assets.icons.flowerLogo,
                  height: 20,
                  width: 20,
                ),
                const SizedBox(width: 4),
                Text(
                  context.l10n.flowery,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.mainColor,
                    fontFamily: FontFamily.iMFellEnglish,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: SizedBox(
                    height: 36,
                    child: CustomSearchBar(hintText: context.l10n.searchHint),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: () => _showAddressSelectionBottomSheet(
                context,
                addresses,
                displayAddress,
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
            ),
          ],
        );
      },
    );
  }

  void _showAddressSelectionBottomSheet(
    BuildContext context,
    List<AddressEntity> addresses,
    AddressEntity? currentSelected,
  ) {
    if (addresses.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(context.l10n.noSavedAddresses)));
      return;
    }

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (bottomSheetContext) {
        return AddressSelectionBottomSheet(
          addresses: addresses,
          selectedAddress: currentSelected,
          onAddressSelected: (address) {
            setState(() {
              selectedAddressId = address.id;
            });
          },
        );
      },
    );
  }
}


