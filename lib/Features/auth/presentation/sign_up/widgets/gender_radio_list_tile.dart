// ignore_for_file: deprecated_member_use

import 'package:flowers_app/core/constants/app_colors.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

class GenderRadioListTile extends StatefulWidget {
  final void Function(Gender?)? onChanged;
  final Gender? selectedGender;

  const GenderRadioListTile({super.key, this.onChanged, this.selectedGender});

  @override
  State<GenderRadioListTile> createState() => _GenderRadioListTileState();
}

class _GenderRadioListTileState extends State<GenderRadioListTile> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          (context).l10n.genderLabel,
          style: Theme.of(
            context,
          ).textTheme.headlineMedium!.copyWith(color: AppColors.gray),
        ),
        IntrinsicWidth(
          child: RadioListTile(
            title: Text(
              (context).l10n.genderFemale,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(),
            ),
            value: Gender.female,
            groupValue: widget.selectedGender,
            onChanged: widget.onChanged,
            activeColor: AppColors.mainColor,
            fillColor: MaterialStateProperty.resolveWith<Color>((states) {
              if (states.contains(MaterialState.selected)) {
                return AppColors.mainColor;
              }
              return AppColors.gray;
            }),
          ),
        ),
        IntrinsicWidth(
          child: RadioListTile(
            title: Text(
              (context).l10n.genderMale,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            value: Gender.male,
            groupValue: widget.selectedGender,
            onChanged: widget.onChanged,
            activeColor: AppColors.mainColor,
            fillColor: MaterialStateProperty.resolveWith<Color>((states) {
              if (states.contains(MaterialState.selected)) {
                return AppColors.mainColor;
              }
              return AppColors.gray;
            }),
          ),
        ),
      ],
    );
  }
}

enum Gender { female, male }
