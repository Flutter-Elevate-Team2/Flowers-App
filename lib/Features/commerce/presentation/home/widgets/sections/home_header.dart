import 'package:flowers_app/Features/commerce/presentation/home/widgets/shared/custom_search_bar.dart';
import 'package:flowers_app/core/constants/app_colors.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flowers_app/core/widget/address_selector.dart';
import 'package:flowers_app/gen/assets.gen.dart';
import 'package:flowers_app/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // === Top Row: Logo + Search Bar ===
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              Assets.icons.flowerLogo,
              height: 20, width: 20,
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
        // === Bottom Row: Address Selector Widget ===
        const AddressSelector(),
      ],
    );
  }
}
