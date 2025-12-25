import 'package:flowers_app/Features/auth/presentation/forget_password/widgets/custom_text_section.dart';
import 'package:flowers_app/Features/auth/presentation/forget_password/widgets/otp_input_widget.dart';
import 'package:flowers_app/Features/auth/presentation/forget_password/widgets/resend_code_text.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

class SendCodeScreenBody extends StatelessWidget {
  const SendCodeScreenBody({super.key, required this.onNextPage});

  final VoidCallback onNextPage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          SizedBox(height: 40),
          TextSection(
            tittle: context.l10n.verificationTitle,
            subTitle: context.l10n.verificationSubTitle,
          ),
          SizedBox(height: 32),
          OtpInputWidget(
            length: 6,
            onCompleted: (value) {
              // TODO: Verify OTP with API
             
              onNextPage();
            },
          ),
          SizedBox(height: 32),
          ResendCodeText(),
        ],
      ),
    );
  }
}
