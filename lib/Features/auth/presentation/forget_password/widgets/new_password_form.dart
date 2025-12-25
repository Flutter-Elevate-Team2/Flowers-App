import 'package:flowers_app/Features/auth/presentation/forget_password/view_model/forget_password_cubit.dart';
import 'package:flowers_app/Features/auth/presentation/forget_password/view_model/forget_password_intent.dart';
import 'package:flowers_app/Features/auth/presentation/forget_password/view_model/forget_password_states.dart';
import 'package:flowers_app/core/constants/app_colors.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flowers_app/core/helpers/form_validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewPasswordForm extends StatefulWidget {
  const NewPasswordForm({super.key, this.userEmail});

  final String? userEmail;

  @override
  State<NewPasswordForm> createState() => _NewPasswordFormState();
}

class _NewPasswordFormState extends State<NewPasswordForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _newPassword = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  bool _isNewPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  @override
  void dispose() {
    _newPassword.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      // Get email from widget parameter or cubit state
      final email = widget.userEmail ?? '';

      if (email.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(context.l10n.emailLabel + ' is required'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
      context.read<ForgetPasswordCubit>().doIntent(
        ResetPassword(newPassword: _newPassword.text.trim(), email: email),
      );
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
        final resetPasswordState = state.resetPasswordState;

        if (resetPasswordState?.data != null &&
            resetPasswordState?.isLoading == false) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
              title: const Text('Success'),
              content: const Text(
                'Password reset successfully! Please login with your new password.',
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Pop dialog
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        } else if (resetPasswordState?.errorMessage != null &&
            resetPasswordState?.isLoading == false) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(resetPasswordState!.errorMessage!),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state.resetPasswordState?.isLoading ?? false;

        return Form(
          key: _formKey,
          autovalidateMode: _autovalidateMode,
          child: Column(
            children: [
              TextFormField(
                validator: (value) =>
                    FormValidators.validatePassword(context, value),
                controller: _newPassword,
                obscureText: !_isNewPasswordVisible,
                enabled: !isLoading,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _isNewPasswordVisible = !_isNewPasswordVisible;
                      });
                    },
                    icon: _isNewPasswordVisible
                        ? const Icon(Icons.visibility, color: AppColors.gray)
                        : const Icon(
                            Icons.visibility_off,
                            color: AppColors.gray,
                          ),
                  ),
                  labelText: context.l10n.newPasswordLabel,
                  hintText: context.l10n.passwordHint,
                ),
              ),
              const SizedBox(height: 24),
              TextFormField(
                validator: (value) => FormValidators.validateConfirmPassword(
                  context,
                  value,
                  _newPassword.text.trim(),
                ),
                controller: _confirmPassword,
                obscureText: !_isConfirmPasswordVisible,
                enabled: !isLoading,
                decoration: InputDecoration(
                  labelText: context.l10n.confirmPasswordLabel,
                  hintText: context.l10n.confirmPasswordHint,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                      });
                    },
                    icon: _isConfirmPasswordVisible
                        ? const Icon(Icons.visibility, color: AppColors.gray)
                        : const Icon(
                            Icons.visibility_off,
                            color: AppColors.gray,
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
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
