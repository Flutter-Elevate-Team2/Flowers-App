import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// The main title of the application
  ///
  /// In en, this message translates to:
  /// **'Flowers App'**
  String get appTitle;

  /// App Name Logo Text
  ///
  /// In en, this message translates to:
  /// **'Flowery'**
  String get flowery;

  /// Label for the home navigation tab
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// Label for the categories navigation tab
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categories;

  /// Label for the cart navigation tab
  ///
  /// In en, this message translates to:
  /// **'Cart'**
  String get cart;

  /// Label for the profile navigation tab
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// Hint text for search bar
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get searchHint;

  /// Button text to view all items
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get viewAll;

  /// Section title for best sellers
  ///
  /// In en, this message translates to:
  /// **'Best seller'**
  String get bestSeller;

  /// Section title for occasions
  ///
  /// In en, this message translates to:
  /// **'Occasion'**
  String get occasion;

  /// Label for delivery location
  ///
  /// In en, this message translates to:
  /// **'Deliver to'**
  String get deliverTo;

  /// text for location
  ///
  /// In en, this message translates to:
  /// **'2XVP+XC - Sheikh Zayed'**
  String get testLocation;

  /// Button text to retry
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retryButton;

  /// Label for the email input field
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailLabel;

  /// Hint text for the email input field
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get emailHint;

  /// Label for the password input field
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordLabel;

  /// Hint text for the password input field
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get passwordHint;

  /// Label for the confirm password input field
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirmPasswordLabel;

  /// Hint text for the confirm password input field
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirmPasswordHint;

  /// Label for the phone number input field
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get phoneLabel;

  /// Hint text for the phone number input field
  ///
  /// In en, this message translates to:
  /// **'Enter phone number'**
  String get phoneHint;

  /// Label for the first name input field
  ///
  /// In en, this message translates to:
  /// **'First name'**
  String get firstNameLabel;

  /// Hint text for the first name input field
  ///
  /// In en, this message translates to:
  /// **'Enter first name'**
  String get firstNameHint;

  /// Label for the last name input field
  ///
  /// In en, this message translates to:
  /// **'Last name'**
  String get lastNameLabel;

  /// Hint text for the last name input field
  ///
  /// In en, this message translates to:
  /// **'Enter last name'**
  String get lastNameHint;

  /// Title for the login screen
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginTitle;

  /// Label for remember me checkbox
  ///
  /// In en, this message translates to:
  /// **'Remember me'**
  String get rememberMe;

  /// Link text for forgot password
  ///
  /// In en, this message translates to:
  /// **'Forget password?'**
  String get forgotPasswordLink;

  /// Button text for guest login
  ///
  /// In en, this message translates to:
  /// **'Continue as guest'**
  String get guestLogin;

  /// Text prompting user to sign up
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? Sign up'**
  String get noAccountSignUp;

  /// Title for the sign up screen
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get signUpTitle;

  /// Label for gender selection
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get genderLabel;

  /// Option for male gender
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get genderMale;

  /// Option for female gender
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get genderFemale;

  /// Terms and conditions agreement text
  ///
  /// In en, this message translates to:
  /// **'Creating an account, you agree to our Terms & Conditions'**
  String get termsConditions;

  /// Text prompting user to login if they have an account
  ///
  /// In en, this message translates to:
  /// **'Already have an account? Login'**
  String get haveAccountLogin;

  /// Title for the forgot password screen
  ///
  /// In en, this message translates to:
  /// **'Forget password'**
  String get forgotPasswordTitle;

  /// Subtitle instructions for forgot password
  ///
  /// In en, this message translates to:
  /// **'Please enter your email associated to your account'**
  String get forgotPasswordSubTitle;

  /// Label for confirm buttons
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirmButton;

  /// Title for the email verification screen
  ///
  /// In en, this message translates to:
  /// **'Email verification'**
  String get verificationTitle;

  /// Subtitle instructions for email verification
  ///
  /// In en, this message translates to:
  /// **'Please enter your code that sent to your email address'**
  String get verificationSubTitle;

  /// Button text to resend verification code
  ///
  /// In en, this message translates to:
  /// **'Didn\'t receive code? Resend'**
  String get resendCode;

  /// Title for the reset password screen
  ///
  /// In en, this message translates to:
  /// **'Reset password'**
  String get resetPasswordTitle;

  /// Label for the new password input field
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get newPasswordLabel;

  /// Validation message when email is empty
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get emailRequired;

  /// Validation message when email format is wrong
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email'**
  String get emailInvalid;

  /// Validation message when password is empty
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get passwordRequired;

  /// Validation message when password is short
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters'**
  String get passwordTooShort;

  /// Validation message when password complexity is low
  ///
  /// In en, this message translates to:
  /// **'Password must contain uppercase, lowercase, number and special character'**
  String get passwordWeak;

  /// Validation message when confirm password fails
  ///
  /// In en, this message translates to:
  /// **'Passwords don\'t match'**
  String get passwordMismatch;

  /// Validation message when name is empty
  ///
  /// In en, this message translates to:
  /// **'Name is required'**
  String get nameRequired;

  /// Validation message when first name is empty
  ///
  /// In en, this message translates to:
  /// **'First name is required'**
  String get firstNameRequired;

  /// Validation message when last name is empty
  ///
  /// In en, this message translates to:
  /// **'Last name is required'**
  String get lastNameRequired;

  /// Validation message when phone is empty
  ///
  /// In en, this message translates to:
  /// **'Phone number is required'**
  String get phoneRequired;

  /// Validation message when phone format is wrong
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid phone number'**
  String get phoneInvalid;

  /// Validation message for incomplete OTP code
  ///
  /// In en, this message translates to:
  /// **'Please enter complete 6-digit code'**
  String get validationEnterCompleteCode;

  /// Generic error message for invalid email format
  ///
  /// In en, this message translates to:
  /// **'This Email is not valid'**
  String get invalidEmailError;

  /// Generic error message for incorrect password
  ///
  /// In en, this message translates to:
  /// **'Invalid password'**
  String get invalidPasswordError;

  /// Generic error message for weak password validation
  ///
  /// In en, this message translates to:
  /// **'Password must not be empty and must contain 6 characters with upper case letter and one number at least'**
  String get weakPasswordError;

  /// Generic error message for invalid verification code
  ///
  /// In en, this message translates to:
  /// **'Invalid code'**
  String get invalidCodeError;

  /// Error message for connection timeout
  ///
  /// In en, this message translates to:
  /// **'Connection timeout. Please check your internet.'**
  String get connectionTimeoutError;

  /// Error message for send timeout
  ///
  /// In en, this message translates to:
  /// **'Request timeout. Please try again.'**
  String get sendTimeoutError;

  /// Error message for receive timeout
  ///
  /// In en, this message translates to:
  /// **'Server took too long to respond.'**
  String get receiveTimeoutError;

  /// Generic connection error message
  ///
  /// In en, this message translates to:
  /// **'Connection error. Please check your network.'**
  String get connectionError;

  /// Error message for no internet connection
  ///
  /// In en, this message translates to:
  /// **'No internet connection.'**
  String get noInternetError;

  /// Generic network error message
  ///
  /// In en, this message translates to:
  /// **'Network error occurred.'**
  String get networkError;

  /// Error message when request is cancelled
  ///
  /// In en, this message translates to:
  /// **'Request was cancelled.'**
  String get requestCancelledError;

  /// Error message for bad SSL certificate
  ///
  /// In en, this message translates to:
  /// **'Security certificate error.'**
  String get badCertificateError;

  /// Error message for 400 Bad Request
  ///
  /// In en, this message translates to:
  /// **'Invalid request.'**
  String get badRequestError;

  /// Error message for 401 Unauthorized
  ///
  /// In en, this message translates to:
  /// **'Session expired. Please login again.'**
  String get unauthorizedError;

  /// Error message for 403 Forbidden
  ///
  /// In en, this message translates to:
  /// **'Access denied.'**
  String get forbiddenError;

  /// Error message for 404 Not Found
  ///
  /// In en, this message translates to:
  /// **'Resource not found.'**
  String get notFoundError;

  /// Error message for 409 Conflict
  ///
  /// In en, this message translates to:
  /// **'Data conflict occurred.'**
  String get conflictError;

  /// Error message for 500 Internal Server Error
  ///
  /// In en, this message translates to:
  /// **'Server error. Try again later.'**
  String get internalServerError;

  /// Error message for 503 Service Unavailable
  ///
  /// In en, this message translates to:
  /// **'Service unavailable.'**
  String get serviceUnavailableError;

  /// Error message for format exception
  ///
  /// In en, this message translates to:
  /// **'Data format error.'**
  String get formatExceptionError;

  /// Error message for data parsing issues
  ///
  /// In en, this message translates to:
  /// **'Error parsing data. Please try again.'**
  String get parsingError;

  /// Firebase error: User not found
  ///
  /// In en, this message translates to:
  /// **'No user found for this email.'**
  String get firebaseUserNotFound;

  /// Firebase error: Wrong password
  ///
  /// In en, this message translates to:
  /// **'Wrong password.'**
  String get firebaseWrongPassword;

  /// Firebase error: Email in use
  ///
  /// In en, this message translates to:
  /// **'Email already in use.'**
  String get firebaseEmailInUse;

  /// Firebase error: Invalid email
  ///
  /// In en, this message translates to:
  /// **'Invalid email format.'**
  String get firebaseInvalidEmail;

  /// Firebase error: Weak password
  ///
  /// In en, this message translates to:
  /// **'Password is too weak.'**
  String get firebaseWeakPassword;

  /// Firebase error: Account disabled
  ///
  /// In en, this message translates to:
  /// **'Account disabled.'**
  String get firebaseAccountDisabled;

  /// Firebase error: Too many requests
  ///
  /// In en, this message translates to:
  /// **'Too many requests. Try again later.'**
  String get firebaseTooManyRequests;

  /// Firebase error: Unknown auth error
  ///
  /// In en, this message translates to:
  /// **'Authentication failed.'**
  String get firebaseAuthUnknown;

  /// Firebase error: Permission denied
  ///
  /// In en, this message translates to:
  /// **'Permission denied.'**
  String get firebasePermissionDenied;

  /// Firebase error: Service unavailable
  ///
  /// In en, this message translates to:
  /// **'Firebase service unavailable.'**
  String get firebaseUnavailable;

  /// Error message for Hive database issues
  ///
  /// In en, this message translates to:
  /// **'Database error (Hive).'**
  String get hiveError;

  /// Error message for platform exceptions
  ///
  /// In en, this message translates to:
  /// **'System error occurred.'**
  String get platformError;

  /// Fallback generic error message
  ///
  /// In en, this message translates to:
  /// **'Something went wrong.'**
  String get defaultError;

  /// Fallback unknown error message
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred.'**
  String get unknownError;

  /// Title for the session expired dialog
  ///
  /// In en, this message translates to:
  /// **'Session Expired'**
  String get sessionExpiredTitle;

  /// Content message for the session expired dialog
  ///
  /// In en, this message translates to:
  /// **'Please log in again to continue.'**
  String get sessionExpiredMessage;

  /// Label for the login button
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginButton;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
