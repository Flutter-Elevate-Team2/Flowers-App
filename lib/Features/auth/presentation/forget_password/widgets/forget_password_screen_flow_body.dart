import 'package:flowers_app/Features/auth/presentation/forget_password/widgets/forget_password_pageview.dart';
import 'package:flutter/material.dart';

class ForgetPasswordScreenFlowBody extends StatefulWidget {
  const ForgetPasswordScreenFlowBody({super.key});

  @override
  State<ForgetPasswordScreenFlowBody> createState() =>
      _ForgetPasswordScreenFlowBodyState();
}

class _ForgetPasswordScreenFlowBodyState
    extends State<ForgetPasswordScreenFlowBody> {
  late PageController _pageController;
  var currentPage = 0;
  String? userEmail; // Store email for later use in reset password

  @override
  void initState() {
    _pageController = PageController();
    _pageController.addListener(() {
      currentPage = _pageController.page!.round();
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void goToNextPage() {
    if (currentPage < 2) {
      _pageController.animateToPage(
        currentPage + 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  void goToPreviousPage() {
    if (currentPage > 0) {
      _pageController.animateToPage(
        currentPage - 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ForgetPasswordPageview(
      pageController: _pageController,
      onNextPage: goToNextPage,
      onPreviousPage: goToPreviousPage,
      onEmailSubmitted: (email) {
        setState(() {
          userEmail = email;
        });
      },
      userEmail: userEmail,
    );
  }
}
