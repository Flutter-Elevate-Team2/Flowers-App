import 'package:flowers_app/core/l10n/app_localizations.dart';
import 'package:flowers_app/core/widget/custom_button.dart';
import 'package:flutter/material.dart';

class AddAddressButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const AddAddressButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      title: AppLocalizations.of(context)!.addNewAddress,
      onPressed: onPressed,
    );
  }
}
