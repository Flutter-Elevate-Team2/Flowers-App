import 'package:flowers_app/Features/auth/presentation/forget_password/widgets/email_screen.dart';
import 'package:flowers_app/Features/auth/presentation/forget_password/widgets/new_password_screen.dart';
import 'package:flowers_app/Features/auth/presentation/forget_password/widgets/send_code_screen.dart';
import 'package:flutter/material.dart';

class ForgetPasswordPageview extends StatelessWidget {
  const ForgetPasswordPageview({
    super.key,
    required this.pageController,
    required this.onNextPage,
    required this.onPreviousPage,
    this.onEmailSubmitted,
    this.userEmail,
    this.otpErrorMessage,
  });

  final PageController pageController;
  final VoidCallback onNextPage;
  final VoidCallback onPreviousPage;
  final void Function(String email)? onEmailSubmitted;
  final String? userEmail;
  final String? otpErrorMessage;

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      physics:
          const NeverScrollableScrollPhysics(), // Disable swipe to control navigation
      children: [
        EmailScreen(onNextPage: onNextPage, onEmailSubmitted: onEmailSubmitted),
        SendCodeScreen(
          onPreviousPage: onPreviousPage,
          onNextPage: onNextPage,
          errorMessage: otpErrorMessage,
        ),
        NewPasswordScreen(onPreviousPage: onPreviousPage, userEmail: userEmail),
      ],
    );
  }
}
