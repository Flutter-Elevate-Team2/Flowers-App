import 'package:flowers_app/Features/auth/presentation/sign_in/widgets/guest_button.dart';
import 'package:flowers_app/Features/auth/presentation/sign_in/widgets/login_button.dart';
import 'package:flowers_app/Features/auth/presentation/sign_in/widgets/remember_me_row.dart';
import 'package:flowers_app/Features/auth/presentation/sign_in/widgets/sign_up_row.dart';
import 'package:flowers_app/core/constants/app_colors.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flowers_app/core/helpers/form_validators.dart';
import 'package:flutter/material.dart';

class LoginScreenBody extends StatefulWidget {
  LoginScreenBody({super.key});

  @override
  State<LoginScreenBody> createState() => _LoginScreenBodyState();
}

class _LoginScreenBodyState extends State<LoginScreenBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _rememberMe = false;
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: _autovalidateMode,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: TextFormField(
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                validator: (value) =>
                    FormValidators.validateEmail(context, value),
                controller: _emailController,
                style: Theme.of(context).textTheme.bodySmall,
                decoration: InputDecoration(
                  labelText: context.l10n.emailLabel,
                  hintText: context.l10n.emailHint,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
            ),
            TextFormField(
              textInputAction: TextInputAction.next,

              validator: (value) =>
                  FormValidators.validatePassword(context, value),
              obscureText: !_isPasswordVisible,
              controller: _passwordController,
              style: Theme.of(context).textTheme.bodySmall,
              decoration: InputDecoration(
                labelText: (context).l10n.passwordLabel,
                hintText: (context).l10n.passwordHint,
                floatingLabelBehavior: FloatingLabelBehavior.always,
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
            RememberMeRow(
              rememberMe: _rememberMe,
              onChanged: (value) =>
                  setState(() => _rememberMe = value ?? false),
              onForgotPassword: () {},
            ),
            LoginButton(onPressed: () {}),
            GuestButton(onPressed: () {}),
            SignUpRow(),
          ],
        ),
      ),
    );
  }
}
