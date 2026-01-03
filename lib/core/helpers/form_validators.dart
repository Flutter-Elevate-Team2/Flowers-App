import 'package:flowers_app/core/l10n/app_localizations.dart';
import 'package:flutter/widgets.dart';
import 'package:flowers_app/core/helpers/app_regex.dart';

class FormValidators {
  FormValidators._();

  static String? validateEmail(BuildContext context, String? value) {
    final trimmedValue = value?.trim();
    if (trimmedValue == null || trimmedValue.isEmpty) {
      return AppLocalizations.of(context)!.emailRequired;
    }
    if (!AppRegex.isEmailValid(trimmedValue)) {
      return AppLocalizations.of(context)!.emailInvalid;
    }
    return null;
  }

  static String? validatePassword(BuildContext context, String? value) {
    final trimmedValue = value?.trim();
    if (trimmedValue == null || trimmedValue.isEmpty) {
      return AppLocalizations.of(context)!.passwordRequired;
    }
    if (!AppRegex.hasMinLength(trimmedValue)) {
      return AppLocalizations.of(context)!.passwordTooShort;
    }
    if (!AppRegex.isPasswordValid(trimmedValue)) {
      return AppLocalizations.of(context)!.passwordWeak;
    }
    return null;
  }

  static String? validateConfirmPassword(BuildContext context, String? value, String password) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.passwordRequired;
    }
    if (value != password) {
      return AppLocalizations.of(context)!.passwordMismatch;
    }
    return null;
  }

  static String? validatePhone(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.phoneRequired;
    }
    if (!AppRegex.isPhoneNumberValid(value)) {
      return AppLocalizations.of(context)!.phoneInvalid;
    }
    return null;
  }

  static String? validateRequired(String? value, String errorMessage) {
    if (value == null || value.isEmpty) {
      return errorMessage;
    }
    return null;
  }
   static String? validateLoginPassword(
    BuildContext context,
    String? value,
) {
  final trimmedValue = value?.trim();

  if (trimmedValue == null || trimmedValue.isEmpty) {
    return AppLocalizations.of(context)!.passwordRequired;
  }


  return null;
}

}
