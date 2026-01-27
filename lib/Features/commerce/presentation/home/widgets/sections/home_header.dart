import 'package:flowers_app/Features/commerce/presentation/home/widgets/sections/address_selection_bottom_sheet.dart';
import 'package:flowers_app/Features/commerce/presentation/home/widgets/shared/custom_search_bar.dart';
import 'package:flowers_app/Features/user_address/domain/entities/address_entity.dart';
import 'package:flowers_app/Features/user_address/presentation/view_model/user_address_event.dart';
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
  AddressEntity? selectedAddress;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserAddressViewModel, UserAddressState>(
      listener: (context, state) {
        // Set initial address if null
        if (state.getAddressesState?.data != null &&
            selectedAddress == null &&
            state.getAddressesState!.data!.addresses.isNotEmpty) {
          setState(() {
            selectedAddress = state.getAddressesState!.data!.addresses.first;
          });
        }

        // Refresh addresses when a new address is added
        if (state.addAddressState?.data != null &&
            state.addAddressState!.isLoading == false) {
          context.read<UserAddressViewModel>().doIntent(GetAddressesEvent());
        }

        // Refresh addresses when an address is edited
        if (state.editAddressState?.data != null &&
            state.editAddressState!.isLoading == false) {
          context.read<UserAddressViewModel>().doIntent(GetAddressesEvent());
        }
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // === Top Row: Logo + Search Bar ===
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // 1. Logo Part
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

                // 2. Search Bar Part
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
              onTap: () => _showAddressSelectionBottomSheet(context, state),
              child: Row(
                children: [
                  const Icon(Icons.location_on_outlined, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    "${selectedAddress?.street ?? context.l10n.deliverTo} ",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Flexible(
                    child: Text(
                      selectedAddress?.city ?? 'Select Address',
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
    UserAddressState state,
  ) {
    final addresses = state.getAddressesState?.data?.addresses ?? [];

    if (addresses.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('No saved addresses found')));
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
          selectedAddress: selectedAddress,
          onAddressSelected: (address) {
            setState(() {
              selectedAddress = address;
            });
          },
        );
      },
    );
  }
}
