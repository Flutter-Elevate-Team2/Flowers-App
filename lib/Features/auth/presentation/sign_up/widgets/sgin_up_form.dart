import 'package:flowers_app/Features/auth/presentation/sign_up/view_model/sign_up_events.dart';
import 'package:flowers_app/Features/auth/presentation/sign_up/view_model/sign_up_states.dart';
import 'package:flowers_app/Features/auth/presentation/sign_up/view_model/sign_up_view_model.dart';
import 'package:flowers_app/Features/auth/presentation/sign_up/widgets/gender_radio_list_tile.dart';
import 'package:flowers_app/Features/auth/presentation/sign_up/widgets/terms_conditions_text.dart';
import 'package:flowers_app/core/app_router/app_router.dart';
import 'package:flowers_app/core/constants/app_colors.dart';
import 'package:flowers_app/core/constants/constant_keys.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flowers_app/core/helpers/form_validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  Gender? _selectedGender;

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

      child: BlocListener<SignUpViewModel, SignUpStates>(
        listener: (context, state) {
          final signUpState = state.signUpState;

          if (signUpState?.data != null) {
            context.goNamed(Routes.homeName);
          } else if (signUpState?.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(signUpState!.errorMessage!),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
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
                      helperText: "",
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
                      helperText: "",
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            TextFormField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,

              validator: (value) =>
                  FormValidators.validateEmail(context, value),
              controller: _emailController,
              style: Theme.of(context).textTheme.bodySmall,
              decoration: InputDecoration(
                labelText: (context).l10n.emailLabel,
                hintText: (context).l10n.emailHint,
                helperText: "",
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
                      helperText: "",

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

                    validator: (value) =>
                        FormValidators.validateConfirmPassword(
                          context,
                          value,
                          _passwordController.text,
                        ),
                    obscureText: !_isConfirmPasswordVisible,
                    controller: _confirmPasswordController,
                    style: Theme.of(context).textTheme.bodySmall,
                    decoration: InputDecoration(
                      labelText: (context).l10n.confirmPasswordLabel,
                      hintText: (context).l10n.confirmPasswordHint,
                      helperText: "",

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

              // validator: (value) =>
              //     FormValidators.validatePhone(context, value),
              controller: _phoneController,
              style: Theme.of(context).textTheme.bodySmall,
              decoration: InputDecoration(
                labelText: (context).l10n.phoneLabel,
                hintText: (context).l10n.phoneHint,
                helperText: "",
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 24),
            GenderRadioListTile(
              selectedGender: _selectedGender,
              onChanged: (value) {
                setState(() {
                  _selectedGender = value;
                });
              },
            ),
            const SizedBox(height: 16),
            const TermsAndConditionsText(),

            SizedBox(height: 48),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: BlocBuilder<SignUpViewModel, SignUpStates>(
                builder: (context, state) {
                  final isLoading = state.signUpState?.isLoading ?? false;
                  return ElevatedButton(
                    onPressed: isLoading
                        ? null
                        : () {
                            setState(() {
                              _autovalidateMode = AutovalidateMode.always;
                            });
                            if (_formKey.currentState!.validate()) {
                              context.read<SignUpViewModel>().doIntent(
                                OnSignUpClickEvent(
                                  firstName: _firstNameController.text,
                                  lastName: _lastNameController.text,
                                  email: _emailController.text,
                                  phone: _phoneController.text,
                                  password: _passwordController.text,
                                  confirmPassword:
                                      _confirmPasswordController.text,
                                  gender:
                                      _selectedGender?.name ??
                                      context.l10n.genderMale,
                                ),
                              );
                            }
                          },
                    child: isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Text((context).l10n.signUpTitle),
                  );
                },
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
                    onTap: () {
                      // navigate to login page after m
                      //context.goNamed(Routes.loginName);
                    },
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
      ),
    );
  }
}
