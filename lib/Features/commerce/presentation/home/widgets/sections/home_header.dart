import 'package:flowers_app/Features/commerce/presentation/home/widgets/shared/custom_search_bar.dart';
import 'package:flowers_app/Features/order/presentation/cart/widgets/shared/add_to_cart_button/login_required_dialog.dart';
import 'package:flowers_app/Features/user_address/presentation/view_model/user_address_state.dart';
import 'package:flowers_app/Features/user_address/presentation/view_model/user_address_view_model.dart';
import 'package:flowers_app/core/constants/app_colors.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flowers_app/core/widget/address_selector.dart';
import 'package:flowers_app/core/widget/selected_address_cubit.dart';
import 'package:flowers_app/gen/assets.gen.dart';
import 'package:flowers_app/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(Assets.icons.flowerLogo, height: 20, width: 20),
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

        BlocListener<UserAddressViewModel, UserAddressState>(
          listenWhen: (prev, curr) =>
              prev.getAddressesState?.data != curr.getAddressesState?.data,
          listener: (context, state) {
            final addresses = state.getAddressesState?.data?.addresses ?? [];
            final selectedCubit = context.read<SelectedAddressCubit>();
            final currentSelected = selectedCubit.state;

            if (addresses.isNotEmpty) {
              if (currentSelected == null) {
                selectedCubit.select(addresses.first);
              } else {
                final updatedAddress = addresses.firstWhere(
                  (a) => a.id == currentSelected.id,
                  orElse: () => addresses.first,
                );
                selectedCubit.select(updatedAddress);
              }
            }
          },
          child: BlocBuilder<UserAddressViewModel, UserAddressState>(
            buildWhen: (previous, current) =>
                previous.isGuest != current.isGuest,
            builder: (context, state) {
              final isGuest = state.isGuest;

              return GestureDetector(
                onTap: () {
                  if (isGuest) {
                    showDialog(
                      context: context,
                      builder: (context) => LoginRequiredDialog(
                        content: context.l10n.pleaseLoginToAdd,
                      ),
                    );
                  }
                },
                child: AbsorbPointer(
                  absorbing: isGuest,
                  child: const AddressSelector(),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
