import 'package:flowers_app/Features/auth/presentation/forget_password/view_model/forget_password_cubit.dart';
import 'package:flowers_app/Features/auth/presentation/forget_password/view_model/forget_password_intent.dart';
import 'package:flowers_app/Features/auth/presentation/forget_password/view_model/forget_password_states.dart';
import 'package:flowers_app/Features/auth/presentation/forget_password/widgets/custom_text_section.dart';
import 'package:flowers_app/Features/auth/presentation/forget_password/widgets/otp_input_widget.dart';
import 'package:flowers_app/Features/auth/presentation/forget_password/widgets/resend_code_text.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SendCodeScreenBody extends StatelessWidget {
  const SendCodeScreenBody({
    super.key,
    required this.onNextPage,
    this.errorMessage,
  });

  final VoidCallback onNextPage;
  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
      listener: (context, state) {
        if (state.verifyOtpState?.data != null &&
            state.verifyOtpState?.isLoading == false) {
          onNextPage();
        }
      },
      builder: (context, state) {
        final isLoading = state.verifyOtpState?.isLoading ?? false;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 40),
              TextSection(
                tittle: context.l10n.verificationTitle,
                subTitle: context.l10n.verificationSubTitle,
              ),
              const SizedBox(height: 32),
              OtpInputWidget(
                length: 6,
                errorText: state.verifyOtpState?.errorMessage,
                onCompleted: (value) {
                  if (!isLoading) {
                    context.read<ForgetPasswordCubit>().doIntent(
                      VerifyOtp(otp: value),
                    );
                  }
                },
              ),
              const SizedBox(height: 32),
              if (isLoading)
                const CircularProgressIndicator()
              else
                const ResendCodeText(),
            ],
          ),
        );
      },
    );
  }
}
