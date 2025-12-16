import 'package:flowers_app/core/app_strings/app_strings.dart';
import 'package:flowers_app/core/helpers/app_regex.dart';

class FormValidators {
  FormValidators._();

  static String? validateEmail(String? value) {
    final trimmedValue = value?.trim();
    if (trimmedValue == null || trimmedValue.isEmpty) {
      return AppStrings.emailRequired;
    }
    if (!AppRegex.isEmailValid(trimmedValue)) {
      return AppStrings.emailInvalid;
    }
    return null;
  }

  static String? validatePassword(String? value) {
    final trimmedValue = value?.trim();
    if (trimmedValue == null || trimmedValue.isEmpty) {
      return AppStrings.passwordRequired;
    }
    if (!AppRegex.hasMinLength(trimmedValue)) {
      return AppStrings.passwordTooShort;
    }
    if (!AppRegex.isPasswordValid(trimmedValue)) {
      return AppStrings.passwordWeak;
    }
    return null;
  }

  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return AppStrings.passwordRequired;
    }
    if (value != password) {
      return AppStrings.passwordMismatch;
    }
    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.phoneRequired;
    }
    if (!AppRegex.isPhoneNumberValid(value)) {
      return AppStrings.phoneInvalid;
    }
    return null;
  }

  static String? validateRequired(String? value, String errorMessage) {
    if (value == null || value.isEmpty) {
      return errorMessage;
    }
    return null;
  }
}