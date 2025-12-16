class AppStrings {
  static const String appTitle = "Exams App";
  static const String exams = "Exams";
  static const String cancel = "Cancel";
  static const String ok = "OK";
  static const String retry = "Retry";
  static const String close = "Close";
  static const String submit = "Submit";
  static const String next = "Next";
  static const String back = "Back";
  static const String skip = "Skip";
  static const String done = "Done";
  static const String start = "Start";
  static const String defaultLanguageCode = "en";
  static const String apiStatusSuccess = "success";
  static const String apiStatusError = "error:";
  static const String tryagain = "try again";
  static const String search = "search";
  static const String change = "Change";
  // ============= LOGIN SCREEN =============

  static const String emailLabel = "Email";
  static const String emailHint = "Enter your email";
  static const String passwordLabel = "Password";
  static const String passwordHint = "Enter your password";
  static const String forgetPassword = "Forget password?";
  static const String dontHaveAccount = "Don't have an account? ";
  static const String login = "Login";
  static const String signUp = "Sginup";
  static const String rememberMe = "Remember Me";

  // ============= REGISTER SCREEN =============

  static const String userNameLabel = "User name";
  static const String userNameHint = "Enter your user name";

  static const String firstNameLabel = "First name";
  static const String firstNameHint = "Enter your first name";
  static const String lastNameLabel = "Last name";
  static const String lastNameHint = "Enter your last name";
  static const String enterPasswordLabel = "Enter password";
  static const String confirmPasswordHint = "Confirm password";
  static const String newPasswordHint = "New password";
  static const String currentPasswordHint = "Current password";
  static const String phoneLabel = "Phone number";
  static const String phoneHint = "Enter your phone number";
  static const String alreadyHaveAccount = "Already have an account? ";

  // ============= FORGET PASSWORD SCREEN =============

  static const String forgetPasswordTitle = "Forget password";
  static const String forgetPasswordInstruction =
      "Please enter your email associated to your account";
  static const String continueButton = "Continue";

  // ============= RESET PASSWORD SCREEN =============

  static const String resetPasswordTitle = "Reset password";
  static const String resetPasswordSubTitle =
      "Password must not be empty and must contain 6 characters with upper case letter and one number at least ";
  // ============= VERIFICATION CODE SCREEN =============

  static const String emailVerification = "Email Verification ";
  static const String verificationInstruction =
      "please enter your code that send to your email address ";
  static const String didntReceiveCode = "Didn't receive the code? ";
  static const String resend = "Resend";
  static const String invalidCode = "Invalid Code";

  // ============= VALIDATION MESSAGES =============

  static const String emailRequired = "Email is required";
  static const String emailInvalid = "Please enter a valid email";
  static const String passwordRequired = "Password is required";
  static const String passwordTooShort =
      "Password must be at least 8 characters";
  static const String passwordWeak =
      "Password must contain uppercase, lowercase, number and special character";
  static const String passwordMismatch = "Passwords don't match";
  static const String nameRequired = "Name is required";
  static const String firstNameRequired = "First name is required";
  static const String lastNameRequired = "Last name is required";
  static const String phoneRequired = "Phone number is required";

  static const String validationEnterCompleteCode =
      "Please enter complete 6-digit code";

  static const String phoneInvalid = "Please enter a valid phone number";

  // ============= PASSWORD REQUIREMENTS =============

  static const String passwordRequirements = "Password must contain:";
  static const String requirementLowercase = "At least one lowercase letter";
  static const String requirementUppercase = "At least one uppercase letter";
  static const String requirementNumber = "At least one number";
  static const String requirementSpecialChar = "At least one special character";
  static const String requirementMinLength = "At least 8 characters";

  // ============= ERROR MESSAGES =============

  static const String errorInvalidCredentials = "Invalid email or password";
  static const String errorEmailAlreadyExists = "Email already exists";
  static const String errorWeakPassword = "Password is too weak";
  static const String errorUserNotFound = "User not found";
  static const String errorNetworkError =
      "Network error. Please check your connection";
  static const String errorTimeout = "Connection timeout. Please try again";
  static const String errorServerError = "Server error. Please try again later";
  static const String errorUnknown = "Something went wrong. Please try again";
  static const String errorEmailNotFound = "Email not found";
  static const String errorUnauthorized = "Unauthorized access"; // Added
  static const String sessionExpired = "Session Expired";
  static const String sessionExpiredMessage =
      "Your session has expired. Please log in again to continue.";
  static const String errorMapping = "Data mapping error"; // Added
  static const String timeOut = "Time Out!";
  static const String initializing = "Initializing...";
  static const String errorLabel = "Error: ";
  static const String profileScreen = "Profile Screen";
  static const String loading = "Loading";

  // ============= SUCCESS MESSAGES =============

  static const String successAccountCreated = "Account created successfully";
  static const String successPasswordReset = "Password reset successfully";
  static const String successCodeSent = "Verification code sent to your email";
  static const String successVerified = "Email verified successfully";
  static const String successLogin = "Login successful";
  static const String codeVerified = "Code verified: ";

  // ============= LOADING MESSAGES =============

  static const String loadingSigningIn = "Signing in...";
  static const String loadingCreatingAccount = "Creating account...";
  static const String loadingSendingCode = "Sending code...";
  static const String loadingVerifying = "Verifying...";
  static const String loadingResettingPassword = "Resetting password...";
  static const String from = "From:";
  static const String to = "To:";
  static const String minutes = "Minutes";
  static const String question = "Questions";
  static const String instructions = "Instructions";
  static const String textdetails = "Lorem ipsum dolor sit amet consectetur.";

  // ============= Exam =============

  static const String selectTheCorrectlysentence =
      "Select the correctly punctuated sentence.";

  static const String finish = "Finish";
  static const String update = "Update";
  static const String noDataFound = "No data found";
  static const String examDurationNotFound = "Exam duration not found.";
  static const String noQuestionText = "No question text";
  static const String viewScore = "View score";
  static const String examScore = "Exam score";
  static const String yourScore = "Your Score";
  static const String correct = "correct";
  static const String incorrect = "incorrect";
  static const String correctAnswers = "Correct Answers";
  static const String showResults = "Show results";
  static const String startAgain = "Start again";

  // ============= results =============
  static const String failedToLoadResults = "Failed to load results:";
  static const String answers = "Answers";
  static const String noExamsTakenYet = "No exams taken yet.";
  static const String results = "Results";
  static const String profile = 'Profile';
}