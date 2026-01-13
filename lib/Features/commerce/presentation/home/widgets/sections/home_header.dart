import 'package:flowers_app/Features/commerce/presentation/home/widgets/shared/custom_search_bar.dart';
import 'package:flowers_app/core/constants/app_colors.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
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
            // 1. Logo Part
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

        Row(
          children: [
            const Icon(Icons.location_on_outlined, size: 16),
            const SizedBox(width: 4),
            Text(
              "${context.l10n.deliverTo} ",
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Flexible(
              child: Text(
                context.l10n.testLocation,
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
      ],
    );
  }
}
