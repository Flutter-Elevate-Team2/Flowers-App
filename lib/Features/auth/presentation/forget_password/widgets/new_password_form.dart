import 'package:flowers_app/core/app_router/app_router.dart';
import 'package:flowers_app/core/constants/app_colors.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flowers_app/core/helpers/form_validators.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NewPasswordForm extends StatefulWidget {
  const NewPasswordForm({super.key});

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
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: _autovalidateMode,
      child: Column(
        children: [
          TextFormField(
            validator: (value) =>FormValidators.validatePassword(context, value),
            controller: _newPassword,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _isNewPasswordVisible = !_isNewPasswordVisible;
                  });
                },
                icon: _isNewPasswordVisible
                    ? Icon(Icons.visibility, color: AppColors.gray)
                    : Icon(Icons.visibility_off, color: AppColors.gray),
              ),

              labelText: context.l10n.newPasswordLabel,
              hintText: context.l10n.passwordHint,
            ),
          ),
          const SizedBox(height: 24),
          TextFormField(
            validator: (value)=>FormValidators.validateConfirmPassword(context, value, _newPassword.text.trim()),
            controller: _confirmPassword,
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
                    ? Icon(Icons.visibility, color: AppColors.gray)
                    : Icon(Icons.visibility_off, color: AppColors.gray),
              ),
            ),
          ),
          const SizedBox(height: 40),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                if(_formKey.currentState!.validate())
                {
                  context.goNamed(Routes.homeName);
                }
                else {
                  
                  setState(() {
                    _autovalidateMode = AutovalidateMode.onUserInteraction;
                  });
                }
              
              },
              child: Text(context.l10n.confirmButton),
            ),
          ),
        ],
      ),
    );
  }
}
