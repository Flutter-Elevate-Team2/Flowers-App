import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
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
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// The main title of the application
  ///
  /// In en, this message translates to:
  /// **'Flowers App'**
  String get appTitle;

  /// Ok
  ///
  /// In en, this message translates to:
  /// **'Ok'**
  String get ok;

  /// content of dialog
  ///
  /// In en, this message translates to:
  /// **'Password reset successfully! Please login with your new password.'**
  String get resetSuccessfully;

  /// content of dialog
  ///
  /// In en, this message translates to:
  /// **'Your account has been created successfully! Please login to continue '**
  String get registerSuccessfully;

  /// success
  ///
  /// In en, this message translates to:
  /// **'success'**
  String get success;

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
  /// **'Don\'t have an account?'**
  String get noAccountSignUp;

  /// Terms&Conditions link text
  ///
  /// In en, this message translates to:
  /// **'Terms&Conditions'**
  String get termsAndConditions;

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
  /// **'Creating an account, you agree to our '**
  String get termsConditions;

  /// Text prompting user to login if they have an account
  ///
  /// In en, this message translates to:
  /// **'Already have an account? '**
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
  /// **'Didn\'t receive code?'**
  String get resendCode;

  /// Button text to resend verification code
  ///
  /// In en, this message translates to:
  /// **'Resend'**
  String get resend;

  /// Title for the reset password screen
  ///
  /// In en, this message translates to:
  /// **'Reset password'**
  String get resetPasswordTitle;

  /// Subtitle instructions for reset password
  ///
  /// In en, this message translates to:
  /// **'Password must not be empty and must contain 6 characters with upper case letter and one number at least '**
  String get resetPasswordSubTitle;

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
  /// **'Ensure the number starts with +20'**
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

  /// Firebase Firestore error when a document does not exist
  ///
  /// In en, this message translates to:
  /// **'Notification not found. It may have already been removed.'**
  String get firebaseNotFound;

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

  /// No description provided for @egp.
  ///
  /// In en, this message translates to:
  /// **'EGP'**
  String get egp;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status: '**
  String get status;

  /// No description provided for @inStock.
  ///
  /// In en, this message translates to:
  /// **'In stock'**
  String get inStock;

  /// No description provided for @outOfStock.
  ///
  /// In en, this message translates to:
  /// **'Out of stock'**
  String get outOfStock;

  /// No description provided for @includeTax.
  ///
  /// In en, this message translates to:
  /// **'All prices include tax'**
  String get includeTax;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// Label for the occasions category
  ///
  /// In en, this message translates to:
  /// **'Occasions'**
  String get occasions;

  /// Label for the best sellers category
  ///
  /// In en, this message translates to:
  /// **'Best Sellers'**
  String get bestSellers;

  /// Label for the search input field
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get searchLabel;

  /// Message displayed when no search results are found
  ///
  /// In en, this message translates to:
  /// **'No results found'**
  String get searchNoResults;

  /// No description provided for @searchFor.
  ///
  /// In en, this message translates to:
  /// **'Search For Any Product You Want'**
  String get searchFor;

  /// Button text to add an item to the cart
  ///
  /// In en, this message translates to:
  /// **'Add to Cart'**
  String get addToCart;

  /// Button text to open filter options
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filter;

  /// sort options
  ///
  /// In en, this message translates to:
  /// **'Sort by'**
  String get sort;

  /// Sort option for lowest price first
  ///
  /// In en, this message translates to:
  /// **'Lowest Price'**
  String get lowestPrice;

  /// Sort option for highest price first
  ///
  /// In en, this message translates to:
  /// **'Highest Price'**
  String get highestPrice;

  /// Sort option for newest items first
  ///
  /// In en, this message translates to:
  /// **'Newest'**
  String get newest;

  /// Sort option for oldest items first
  ///
  /// In en, this message translates to:
  /// **'Oldest'**
  String get oldest;

  /// Sort option for highest discount first
  ///
  /// In en, this message translates to:
  /// **'Discount'**
  String get discount;

  /// Message displayed when no products are found after filtering or searching
  ///
  /// In en, this message translates to:
  /// **'No products found'**
  String get noProductsFound;

  /// Description for the occasions section
  ///
  /// In en, this message translates to:
  /// **'Bloom with our exquisite best sellers'**
  String get occasionDescription;

  /// Message displayed when a feature requires login
  ///
  /// In en, this message translates to:
  /// **'Login Required'**
  String get loginRequired;

  /// Label for the cancel button in a dialog
  ///
  /// In en, this message translates to:
  /// **'cancel'**
  String get cancelDialog;

  /// Message displayed when we want to add to cart without login
  ///
  /// In en, this message translates to:
  /// **'Please login first to add items to cart'**
  String get pleaseLoginToAdd;

  /// Label for delivery address
  ///
  /// In en, this message translates to:
  /// **'Delivery to'**
  String get deliveryTo;

  /// Label for cart subtotal
  ///
  /// In en, this message translates to:
  /// **'Subtotal'**
  String get subtotal;

  /// Label for delivery fee
  ///
  /// In en, this message translates to:
  /// **'Delivery Fee'**
  String get deliveryFee;

  /// Label for cart total
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// Button text to proceed to checkout
  ///
  /// In en, this message translates to:
  /// **'Checkout'**
  String get checkout;

  /// Label for number of items in cart
  ///
  /// In en, this message translates to:
  /// **'items'**
  String get items;

  /// Message displayed when the cart is empty
  ///
  /// In en, this message translates to:
  /// **'Your cart is empty'**
  String get yourCartIsEmpty;

  /// Encouragement message to add items to the cart
  ///
  /// In en, this message translates to:
  /// **'Add some beautiful flowers to get started 🌸'**
  String get addSomeFlowers;

  /// Message displayed when the user is not logged in
  ///
  /// In en, this message translates to:
  /// **'You are not logged in'**
  String get youAreNotLoggedIn;

  /// Prompt to login to access certain features
  ///
  /// In en, this message translates to:
  /// **'Please Login to view your cart and add items.'**
  String get pleaseLoginToContinue;

  /// Title for edit profile screen
  ///
  /// In en, this message translates to:
  /// **'Edit profile'**
  String get editProfile;

  /// Button text to change password
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get change;

  /// Button text to update profile or password
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// Label for current password field
  ///
  /// In en, this message translates to:
  /// **'Current password'**
  String get currentPasswordLabel;

  /// Hint for current password field
  ///
  /// In en, this message translates to:
  /// **'Current password'**
  String get currentPasswordHint;

  /// Profile menu item for orders
  ///
  /// In en, this message translates to:
  /// **'My orders'**
  String get myOrders;

  /// Profile menu item for saved addresses
  ///
  /// In en, this message translates to:
  /// **'Saved address'**
  String get savedAddress;

  /// Profile menu item for notifications
  ///
  /// In en, this message translates to:
  /// **'Notification'**
  String get notifications;

  /// Profile menu item for language
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// Language option English
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// Language option Arabic
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get arabic;

  /// Profile menu item for about us
  ///
  /// In en, this message translates to:
  /// **'About us'**
  String get aboutUs;

  /// Profile menu item for logout
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// Title for language selection bottom sheet
  ///
  /// In en, this message translates to:
  /// **'Change Language'**
  String get changeLanguage;

  /// Title for logout confirmation dialog
  ///
  /// In en, this message translates to:
  /// **'LOGOUT'**
  String get logoutTitle;

  /// Message asking user to confirm logout
  ///
  /// In en, this message translates to:
  /// **'Confirm logout!!'**
  String get confirmLogout;

  /// Success message after profile update
  ///
  /// In en, this message translates to:
  /// **'Profile updated successfully'**
  String get profileUpdatedSuccess;

  /// No description provided for @photoUploadedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Photo uploaded successfully'**
  String get photoUploadedSuccessfully;

  /// Success message after password change
  ///
  /// In en, this message translates to:
  /// **'Password changed successfully'**
  String get passwordChangedSuccess;

  /// App version display text
  ///
  /// In en, this message translates to:
  /// **'v 6.3.0 - (446)'**
  String get appVersion;

  /// Error message when image selection fails
  ///
  /// In en, this message translates to:
  /// **'Failed to pick image: {error}'**
  String failedToPickImage(String error);

  /// Validation message when a required field is empty
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get required;

  /// guest
  ///
  /// In en, this message translates to:
  /// **'guest'**
  String get guest;

  /// Button text to add a new address
  ///
  /// In en, this message translates to:
  /// **'Add new address'**
  String get addNewAddress;

  /// Success message when address is added
  ///
  /// In en, this message translates to:
  /// **'Address added successfully'**
  String get addressAddedSuccess;

  /// Success message when address is updated
  ///
  /// In en, this message translates to:
  /// **'Address updated successfully'**
  String get addressUpdatedSuccess;

  /// Success message when address is deleted
  ///
  /// In en, this message translates to:
  /// **'Address deleted successfully'**
  String get addressDeletedSuccess;

  /// Text to indicate user can tap to change location
  ///
  /// In en, this message translates to:
  /// **'Tap to change'**
  String get tapToChange;

  /// Label for address input field
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get addressLabel;

  /// Hint for address input field
  ///
  /// In en, this message translates to:
  /// **'Enter your address'**
  String get addressHint;

  /// Validation message when address is empty
  ///
  /// In en, this message translates to:
  /// **'Please enter address'**
  String get addressRequired;

  /// Label for phone number input field
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumberLabel;

  /// Hint for phone number input field
  ///
  /// In en, this message translates to:
  /// **'Enter your phone number'**
  String get phoneNumberHint;

  /// Validation message when phone is empty
  ///
  /// In en, this message translates to:
  /// **'Please enter phone'**
  String get phoneNumberRequired;

  /// Label for recipient name input field
  ///
  /// In en, this message translates to:
  /// **'Recipient name'**
  String get recipientNameLabel;

  /// Hint for recipient name input field
  ///
  /// In en, this message translates to:
  /// **'Enter recipient name'**
  String get recipientNameHint;

  /// Validation message when recipient name is empty
  ///
  /// In en, this message translates to:
  /// **'Please enter name'**
  String get recipientNameRequired;

  /// Label for city dropdown
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get cityLabel;

  /// Hint text for city dropdown
  ///
  /// In en, this message translates to:
  /// **'Cairo'**
  String get cairoHint;

  /// Label for area dropdown
  ///
  /// In en, this message translates to:
  /// **'Area'**
  String get areaLabel;

  /// Hint text for area dropdown
  ///
  /// In en, this message translates to:
  /// **'October'**
  String get octoberHint;

  /// Button text to update an address
  ///
  /// In en, this message translates to:
  /// **'Update Address'**
  String get updateAddress;

  /// Button text to save a new address
  ///
  /// In en, this message translates to:
  /// **'Save Address'**
  String get saveAddress;

  /// Validation message when location is not selected
  ///
  /// In en, this message translates to:
  /// **'Please pick a location on map'**
  String get pleasePickLocation;

  /// Message displayed when there are no saved addresses
  ///
  /// In en, this message translates to:
  /// **'No saved addresses'**
  String get noSavedAddresses;

  /// Title for location picker screen
  ///
  /// In en, this message translates to:
  /// **'Pick Location'**
  String get pickLocation;

  /// Message when location services are disabled
  ///
  /// In en, this message translates to:
  /// **'Location services are disabled. Please enable them.'**
  String get locationServicesDisabled;

  /// Message when location permissions are denied
  ///
  /// In en, this message translates to:
  /// **'Location permissions are denied'**
  String get locationPermissionsDenied;

  /// Message when location permissions are permanently denied
  ///
  /// In en, this message translates to:
  /// **'Location permissions are permanently denied'**
  String get locationPermissionsPermanentlyDenied;

  /// Message when current location is selected
  ///
  /// In en, this message translates to:
  /// **'Current location selected'**
  String get currentLocationSelected;

  /// Error message prefix when getting location fails
  ///
  /// In en, this message translates to:
  /// **'Error getting location: '**
  String get errorGettingLocation;

  /// Label for delivery time
  ///
  /// In en, this message translates to:
  /// **'Delivery time'**
  String get deliveryTime;

  /// Label for delivery schedule
  ///
  /// In en, this message translates to:
  /// **'Schedule'**
  String get schedule;

  /// Option for instant delivery
  ///
  /// In en, this message translates to:
  /// **'Instant, '**
  String get instant;

  /// Label for delivery arrival time
  ///
  /// In en, this message translates to:
  /// **'Arrive by 03 Sep 2024, 11:00 AM'**
  String get arriveBy;

  /// Label for gift option
  ///
  /// In en, this message translates to:
  /// **'It is a gift'**
  String get itIsAGift;

  /// Label for recipient name
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// Hint for recipient name
  ///
  /// In en, this message translates to:
  /// **'Enter the name'**
  String get enterName;

  /// Label for recipient phone number
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get phoneNumber;

  /// Hint for recipient phone number
  ///
  /// In en, this message translates to:
  /// **'Enter the phone number'**
  String get enterPhoneNumber;

  /// Label for payment method
  ///
  /// In en, this message translates to:
  /// **'Payment method'**
  String get paymentMethod;

  /// Option for cash on delivery
  ///
  /// In en, this message translates to:
  /// **'Cash on delivery'**
  String get cashOnDelivery;

  /// Option for credit card payment
  ///
  /// In en, this message translates to:
  /// **'Credit card'**
  String get creditCard;

  /// Label for delivery address
  ///
  /// In en, this message translates to:
  /// **'Delivery address'**
  String get deliveryAddress;

  /// Button text to add a new address
  ///
  /// In en, this message translates to:
  /// **'Add new'**
  String get addNew;

  /// Button text to edit an address
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// Button text to place the order
  ///
  /// In en, this message translates to:
  /// **'Place order'**
  String get placeOrder;

  /// Thank you message
  ///
  /// In en, this message translates to:
  /// **'Thank you!'**
  String get thankYou;

  /// Button text to go to home
  ///
  /// In en, this message translates to:
  /// **'Go to home'**
  String get goToHome;

  /// Success message after order placement
  ///
  /// In en, this message translates to:
  /// **'Your order has been placed successfully. We’ll start preparing it right away 🌸'**
  String get placedSuccessfully;

  /// Title for credit card checkout
  ///
  /// In en, this message translates to:
  /// **'Credit Checkout'**
  String get creditCheckout;

  /// Message displayed when payment is cancelled
  ///
  /// In en, this message translates to:
  /// **'Payment Cancelled'**
  String get paymentCancelled;

  /// loading...
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// Title for address selection screen
  ///
  /// In en, this message translates to:
  /// **'Select Address'**
  String get selectAddress;

  /// Please login to add address
  ///
  /// In en, this message translates to:
  /// **'Please login to add address'**
  String get pleaseLoginToAddAddress;

  /// Status label for active orders
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active;

  /// Status label for completed orders
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// Button text to reorder an order
  ///
  /// In en, this message translates to:
  /// **'Reorder'**
  String get reorder;

  /// Button text to track an order
  ///
  /// In en, this message translates to:
  /// **'Track order'**
  String get trackOrder;

  /// Label for delivery status
  ///
  /// In en, this message translates to:
  /// **'Delivered on'**
  String get deliveredOn;

  /// Label for order number
  ///
  /// In en, this message translates to:
  /// **'Order Number'**
  String get orderNumber;

  /// Message displayed when no orders are found
  ///
  /// In en, this message translates to:
  /// **'No orders found'**
  String get noOrdersFound;

  /// No description provided for @accepted.
  ///
  /// In en, this message translates to:
  /// **'Order Accepted'**
  String get accepted;

  /// No description provided for @picked.
  ///
  /// In en, this message translates to:
  /// **'Being Prepared'**
  String get picked;

  /// No description provided for @outForDelivery.
  ///
  /// In en, this message translates to:
  /// **'Out for Delivery'**
  String get outForDelivery;

  /// No description provided for @delivered.
  ///
  /// In en, this message translates to:
  /// **'Delivered'**
  String get delivered;

  /// No description provided for @receivedYourOrder.
  ///
  /// In en, this message translates to:
  /// **'Received Your Order'**
  String get receivedYourOrder;

  /// No description provided for @preparingYourOrder.
  ///
  /// In en, this message translates to:
  /// **'Preparing Your Order'**
  String get preparingYourOrder;

  /// No description provided for @estimatedArrival.
  ///
  /// In en, this message translates to:
  /// **'Estimated arrival'**
  String get estimatedArrival;

  /// No description provided for @isYourDelivery.
  ///
  /// In en, this message translates to:
  /// **'is your delivery hero for today'**
  String get isYourDelivery;

  /// No description provided for @showMap.
  ///
  /// In en, this message translates to:
  /// **'Show map'**
  String get showMap;

  /// No description provided for @orderDelivered.
  ///
  /// In en, this message translates to:
  /// **'Order Delivered'**
  String get orderDelivered;

  /// No description provided for @arrived.
  ///
  /// In en, this message translates to:
  /// **'Arrived'**
  String get arrived;

  /// FCM error: Invalid service account credentials (401)
  ///
  /// In en, this message translates to:
  /// **'Notification service authentication failed. Please contact support.'**
  String get fcmInvalidCredentials;

  /// FCM error: Invalid or expired device token (404)
  ///
  /// In en, this message translates to:
  /// **'Could not reach the driver. The device token may be expired.'**
  String get fcmInvalidToken;

  /// FCM error: Generic send failure
  ///
  /// In en, this message translates to:
  /// **'Failed to send notification. Please try again.'**
  String get fcmSendFailed;

  /// Snackbar message when silent notification sent successfully
  ///
  /// In en, this message translates to:
  /// **'Delivery confirmed successfully, finalizing order..'**
  String get confirmDeliverySuccess;

  /// Button text while sending silent notification
  ///
  /// In en, this message translates to:
  /// **'Confirming...'**
  String get confirmingDelivery;

  /// Snackbar message when driver token or order ID is missing
  ///
  /// In en, this message translates to:
  /// **'Driver data is incomplete'**
  String get driverDataIncomplete;

  /// No description provided for @orderCancelled.
  ///
  /// In en, this message translates to:
  /// **'Order Cancelled'**
  String get orderCancelled;

  /// No description provided for @orderHasBeenCancelled.
  ///
  /// In en, this message translates to:
  /// **'Your Order has been cancelled please try again'**
  String get orderHasBeenCancelled;

  /// Empty state message for the notifications screen
  ///
  /// In en, this message translates to:
  /// **'No notifications yet'**
  String get noNotifications;

  /// Generic error title on the notifications screen
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get notificationsErrorTitle;

  /// Bouquet include
  ///
  /// In en, this message translates to:
  /// **'Bouquet include'**
  String get bouquetInclude;

  /// Order details
  ///
  /// In en, this message translates to:
  /// **'Order details'**
  String get orderDetails;

  /// Error failed to load products
  ///
  /// In en, this message translates to:
  /// **'Failed to load products'**
  String get failedToLoadProducts;

  /// Error invalid payment session
  ///
  /// In en, this message translates to:
  /// **'Invalid payment session'**
  String get invalidPaymentSession;

  /// Error order not found
  ///
  /// In en, this message translates to:
  /// **'Order Not Found'**
  String get orderNotFound;

  /// Order Accepted Notification Title
  ///
  /// In en, this message translates to:
  /// **'Order Accepted 🌸'**
  String get notifAcceptedTitle;

  /// Order Accepted Notification Body
  ///
  /// In en, this message translates to:
  /// **'Your driver is heading to the store to pick up your blooms.'**
  String get notifAcceptedBody;

  /// Arrived Pickup Notification Title
  ///
  /// In en, this message translates to:
  /// **'At the Store 🏬'**
  String get notifArrivedPickupTitle;

  /// Arrived Pickup Notification Body
  ///
  /// In en, this message translates to:
  /// **'We are picking up your fresh bouquet right now.'**
  String get notifArrivedPickupBody;

  /// Start Deliver Notification Title
  ///
  /// In en, this message translates to:
  /// **'On the Way 🚗'**
  String get notifStartDeliverTitle;

  /// Start Deliver Notification Body
  ///
  /// In en, this message translates to:
  /// **'Your flowers are on the way! Track your driver now.'**
  String get notifStartDeliverBody;

  /// Arrived User Notification Title
  ///
  /// In en, this message translates to:
  /// **'We\'re Here 📍'**
  String get notifArrivedUserTitle;

  /// Arrived User Notification Body
  ///
  /// In en, this message translates to:
  /// **'Your driver has arrived with your flowers. Please step out to receive them.'**
  String get notifArrivedUserBody;

  /// Delivered Notification Title
  ///
  /// In en, this message translates to:
  /// **'Delivered Successfully 🎉'**
  String get notifDeliveredTitle;

  /// Delivered Notification Body
  ///
  /// In en, this message translates to:
  /// **'We hope our flowers brought a smile to your face today!'**
  String get notifDeliveredBody;
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
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
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
