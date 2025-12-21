import 'package:flowers_app/Features/auth/presentation/sign_up/widgets/gender_radio_list_tile.dart';
import 'package:flowers_app/Features/auth/presentation/sign_up/widgets/terms_conditions_text.dart';
import 'package:flowers_app/core/app_router/app_router.dart';
import 'package:flowers_app/core/constants/app_colors.dart';
import 'package:flowers_app/core/constants/constant_keys.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flowers_app/core/helpers/form_validators.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: _autovalidateMode,

      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  validator: (value) => FormValidators.validateRequired(
                    value,
                    context.l10n.firstNameRequired,
                  ),

                  controller: _firstNameController,
                  style: Theme.of(context).textTheme.bodySmall,
                  decoration: InputDecoration(
                    labelText: (context).l10n.firstNameLabel,
                    hintText: (context).l10n.firstNameHint,
                        helperText: ' ',
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  controller: _lastNameController,
                  validator: (value) => FormValidators.validateRequired(
                    value,
                    context.l10n.lastNameRequired,
                  ),
                  style: Theme.of(context).textTheme.bodySmall,
                  decoration: InputDecoration(
                    labelText: (context).l10n.lastNameLabel,
                    hintText: (context).l10n.lastNameHint,
                        helperText: ' ',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          TextFormField(
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,

            validator: (value) => FormValidators.validateEmail(context, value),
            controller: _emailController,
            style: Theme.of(context).textTheme.bodySmall,
            decoration: InputDecoration(
              labelText: (context).l10n.emailLabel,
              hintText: (context).l10n.emailHint,
            ),
          ),
          const SizedBox(height: 24),

          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: TextFormField(
                  textInputAction: TextInputAction.next,

                  validator: (value) =>
                      FormValidators.validatePassword(context, value),
                  onChanged: (_) {
                    if (_confirmPasswordController.text.isNotEmpty) {
                      _formKey.currentState?.validate();
                    }
                  },
                  obscureText: !_isPasswordVisible,
                  controller: _passwordController,
                  style: Theme.of(context).textTheme.bodySmall,
                  decoration: InputDecoration(
                    labelText: (context).l10n.passwordLabel,
                    hintText: (context).l10n.passwordHint,
                    helperText: ' ',
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                      icon: _isPasswordVisible
                          ? Icon(Icons.visibility, color: AppColors.gray)
                          : Icon(Icons.visibility_off, color: AppColors.gray),
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 16),
              Expanded(
                child: TextFormField(
                  textInputAction: TextInputAction.next,

                  validator: (value) => FormValidators.validateConfirmPassword(
                    context,
                    value,
                    _passwordController.text,
                  ),
                  obscureText: !_isConfirmPasswordVisible,
                  controller: _confirmPasswordController,
                  style: Theme.of(context).textTheme.bodySmall,
                  decoration: InputDecoration(
                    helperText: ' ',
                    labelText: (context).l10n.confirmPasswordLabel,
                    hintText: (context).l10n.confirmPasswordHint,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _isConfirmPasswordVisible =
                              !_isConfirmPasswordVisible;
                        });
                      },
                      icon: _isConfirmPasswordVisible
                          ? Icon(Icons.visibility, color: AppColors.gray)
                          : Icon(Icons.visibility_off, color: AppColors.gray),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          TextFormField(
            textInputAction: TextInputAction.done,

            validator: (value) => FormValidators.validatePhone(context, value),
            controller: _phoneController,
            style: Theme.of(context).textTheme.bodySmall,
            decoration: InputDecoration(
              labelText: (context).l10n.phoneLabel,
              hintText: (context).l10n.phoneHint,
            ),
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 24),
          const GenderRadioListTile(),
          const SizedBox(height: 16),
          const TermsAndConditionsText(),

          SizedBox(height: 48),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _autovalidateMode = AutovalidateMode.always;
                });
                if (_formKey.currentState!.validate()) {
                  context.goNamed(Routes.homeName);
                }
              },
              child: Text((context).l10n.signUpTitle),
            ),
          ),
          SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  (context).l10n.haveAccountLogin,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                InkWell(
                  onTap: () {},
                  child: Text(
                    (context).l10n.loginButton,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w400,
                      color: AppColors.mainColor,
                      decoration: TextDecoration.underline,
                      fontFamily: ConstKeys.interFont,
                    ),
                  ),
                ),
               
              ],
            ),
          ),
        ],
      ),
    );
  }
}
