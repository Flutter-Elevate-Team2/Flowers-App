import 'package:flowers_app/Features/auth/presentation/forget_password/view_model/forget_password_cubit.dart';
import 'package:flowers_app/Features/auth/presentation/forget_password/view_model/forget_password_intent.dart';
import 'package:flowers_app/Features/auth/presentation/forget_password/view_model/forget_password_states.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flowers_app/core/helpers/form_validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmailFormSection extends StatefulWidget {
  const EmailFormSection({
    super.key,
    required this.onNextPage,
    this.onEmailSubmitted,
  });

  final VoidCallback onNextPage;
  final void Function(String email)? onEmailSubmitted;

  @override
  State<EmailFormSection> createState() => _EmailFormSectionState();
}

class _EmailFormSectionState extends State<EmailFormSection> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text.trim();

      // Call the callback to store email in parent
      widget.onEmailSubmitted?.call(email);

      // Trigger the cubit to send OTP
      context.read<ForgetPasswordCubit>().doIntent(SendOtp(email: email));
    } else {
      setState(() {
        _autovalidateMode = AutovalidateMode.onUserInteraction;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
      listener: (context, state) {
        final sendOtpState = state.sendOtpState;

        if (sendOtpState?.data != null && sendOtpState?.isLoading == false) {
          widget.onNextPage();
        } else if (sendOtpState?.errorMessage != null &&
            sendOtpState?.isLoading == false) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(sendOtpState!.errorMessage!),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state.sendOtpState?.isLoading ?? false;

        return Form(
          key: _formKey,
          autovalidateMode: _autovalidateMode,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (value) =>
                    FormValidators.validateEmail(context, value),
                style: Theme.of(context).textTheme.bodySmall,
                enabled: !isLoading,
                decoration: InputDecoration(
                  labelText: context.l10n.emailLabel,
                  hintText: context.l10n.emailHint,
                ),
              ),
              const SizedBox(height: 48),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: isLoading ? null : _handleSubmit,
                  child: isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Text(context.l10n.confirmButton),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
