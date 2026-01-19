import 'package:flowers_app/Features/profile/presentation/widgets/gender_section.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

class GenderSelectionSection extends StatelessWidget {
  final String selectedGender;

  const GenderSelectionSection({super.key, required this.selectedGender});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.genderLabel,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            GenderRadioButton(
              label: context.l10n.genderFemale,
              isSelected: selectedGender == 'female',
            ),
            const SizedBox(width: 24),
            GenderRadioButton(
              label: context.l10n.genderMale,
              isSelected: selectedGender == 'male',
            ),
          ],
        ),
      ],
    );
  }
}
