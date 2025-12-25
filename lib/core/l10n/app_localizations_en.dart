// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Flowers App';

  @override
  String get home => 'Home';

  @override
  String get categories => 'Categories';

  @override
  String get cart => 'Cart';

  @override
  String get profile => 'Profile';

  @override
  String get emailLabel => 'Email';

  @override
  String get emailHint => 'Enter your email';

  @override
  String get passwordLabel => 'Password';

  @override
  String get passwordHint => 'Enter your password';

  @override
  String get confirmPasswordLabel => 'Confirm password';

  @override
  String get confirmPasswordHint => 'Confirm password';

  @override
  String get phoneLabel => 'Phone number';

  @override
  String get phoneHint => 'Enter phone number';

  @override
  String get firstNameLabel => 'First name';

  @override
  String get firstNameHint => 'Enter first name';

  @override
  String get lastNameLabel => 'Last name';

  @override
  String get lastNameHint => 'Enter last name';

  @override
  String get loginTitle => 'Login';

  @override
  String get rememberMe => 'Remember me';

  @override
  String get forgotPasswordLink => 'Forget password?';

  @override
  String get guestLogin => 'Continue as guest';

  @override
  String get noAccountSignUp => 'Don\'t have an account? Sign up';

  @override
  String get signUpTitle => 'Sign up';

  @override
  String get genderLabel => 'Gender';

  @override
  String get genderMale => 'Male';

  @override
  String get genderFemale => 'Female';

  @override
  String get termsConditions =>
      'Creating an account, you agree to our Terms & Conditions';

  @override
  String get haveAccountLogin => 'Already have an account? Login';

  @override
  String get forgotPasswordTitle => 'Forget password';

  @override
  String get forgotPasswordSubTitle =>
      'Please enter your email associated to your account';

  @override
  String get confirmButton => 'Confirm';

  @override
  String get verificationTitle => 'Email verification';

  @override
  String get verificationSubTitle =>
      'Please enter your code that sent to your email address';

  @override
  String get resendCode => 'Didn\'t receive code?';

  @override
  String get resend => 'Resend';

  @override
  String get resetPasswordTitle => 'Reset password';

  @override
  String get resetPasswordSubTitle =>
      'Password must not be empty and must contain 6 characters with upper case letter and one number at least ';

  @override
  String get newPasswordLabel => 'New password';

  @override
  String get emailRequired => 'Email is required';

  @override
  String get emailInvalid => 'Please enter a valid email';

  @override
  String get passwordRequired => 'Password is required';

  @override
  String get passwordTooShort => 'Password must be at least 8 characters';

  @override
  String get passwordWeak =>
      'Password must contain uppercase, lowercase, number and special character';

  @override
  String get passwordMismatch => 'Passwords don\'t match';

  @override
  String get nameRequired => 'Name is required';

  @override
  String get firstNameRequired => 'First name is required';

  @override
  String get lastNameRequired => 'Last name is required';

  @override
  String get phoneRequired => 'Phone number is required';

  @override
  String get phoneInvalid => 'Please enter a valid phone number';

  @override
  String get validationEnterCompleteCode =>
      'Please enter complete 6-digit code';

  @override
  String get invalidEmailError => 'This Email is not valid';

  @override
  String get invalidPasswordError => 'Invalid password';

  @override
  String get weakPasswordError =>
      'Password must not be empty and must contain 6 characters with upper case letter and one number at least';

  @override
  String get invalidCodeError => 'Invalid code';

  @override
  String get connectionTimeoutError =>
      'Connection timeout. Please check your internet.';

  @override
  String get sendTimeoutError => 'Request timeout. Please try again.';

  @override
  String get receiveTimeoutError => 'Server took too long to respond.';

  @override
  String get connectionError => 'Connection error. Please check your network.';

  @override
  String get noInternetError => 'No internet connection.';

  @override
  String get networkError => 'Network error occurred.';

  @override
  String get requestCancelledError => 'Request was cancelled.';

  @override
  String get badCertificateError => 'Security certificate error.';

  @override
  String get badRequestError => 'Invalid request.';

  @override
  String get unauthorizedError => 'Session expired. Please login again.';

  @override
  String get forbiddenError => 'Access denied.';

  @override
  String get notFoundError => 'Resource not found.';

  @override
  String get conflictError => 'Data conflict occurred.';

  @override
  String get internalServerError => 'Server error. Try again later.';

  @override
  String get serviceUnavailableError => 'Service unavailable.';

  @override
  String get formatExceptionError => 'Data format error.';

  @override
  String get parsingError => 'Error parsing data. Please try again.';

  @override
  String get firebaseUserNotFound => 'No user found for this email.';

  @override
  String get firebaseWrongPassword => 'Wrong password.';

  @override
  String get firebaseEmailInUse => 'Email already in use.';

  @override
  String get firebaseInvalidEmail => 'Invalid email format.';

  @override
  String get firebaseWeakPassword => 'Password is too weak.';

  @override
  String get firebaseAccountDisabled => 'Account disabled.';

  @override
  String get firebaseTooManyRequests => 'Too many requests. Try again later.';

  @override
  String get firebaseAuthUnknown => 'Authentication failed.';

  @override
  String get firebasePermissionDenied => 'Permission denied.';

  @override
  String get firebaseUnavailable => 'Firebase service unavailable.';

  @override
  String get hiveError => 'Database error (Hive).';

  @override
  String get platformError => 'System error occurred.';

  @override
  String get defaultError => 'Something went wrong.';

  @override
  String get unknownError => 'An unexpected error occurred.';

  @override
  String get sessionExpiredTitle => 'Session Expired';

  @override
  String get sessionExpiredMessage => 'Please log in again to continue.';

  @override
  String get loginButton => 'Login';
}
