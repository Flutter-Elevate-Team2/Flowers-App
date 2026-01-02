import 'package:flowers_app/core/constants/app_colors.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

enum Gender { female, male }

class GenderRadioListTile extends StatelessWidget {
  final Gender? selectedGender;
  final ValueChanged<Gender?> onChanged;

  const GenderRadioListTile({
    super.key,
    required this.selectedGender,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return RadioGroup<Gender>(
      groupValue: selectedGender,
      onChanged: onChanged,
      child: Row(
        children: [
          Text(
            context.l10n.genderLabel, // Fixed: removed ()
            style: Theme.of(
              context,
            ).textTheme.headlineMedium!.copyWith(color: AppColors.gray),
          ),
          const SizedBox(width: 10),
          Expanded(
            // Optimized: Use Expanded instead of IntrinsicWidth
            child: RadioListTile<Gender>(
              contentPadding: EdgeInsets.zero,
              title: Text(
                context.l10n.genderFemale, // Fixed: removed ()
                style: Theme.of(context).textTheme.bodySmall,
              ),
              value: Gender.female,
              activeColor: AppColors.mainColor,
              fillColor: WidgetStateProperty.resolveWith<Color>((states) {
                if (states.contains(WidgetState.selected)) {
                  return AppColors.mainColor;
                }
                return AppColors.gray;
              }),
            ),
          ),
          Expanded(
            child: RadioListTile<Gender>(
              contentPadding: EdgeInsets.zero,
              title: Text(
                context.l10n.genderMale, // Fixed: removed ()
                style: Theme.of(context).textTheme.bodySmall,
              ),
              value: Gender.male,
              activeColor: AppColors.mainColor,
              fillColor: WidgetStateProperty.resolveWith<Color>((states) {
                if (states.contains(WidgetState.selected)) {
                  return AppColors.mainColor;
                }
                return AppColors.gray;
              }),
            ),
          ),
        ],
      ),
    );
  }
}
