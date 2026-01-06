import 'package:flowers_app/Features/auth/presentation/sign_in/view_model/login_event.dart';
import 'package:flowers_app/Features/auth/presentation/sign_in/view_model/login_state.dart';
import 'package:flowers_app/Features/auth/presentation/sign_in/view_model/login_view_model.dart';
import 'package:flowers_app/Features/auth/presentation/sign_in/widgets/guest_button.dart';
import 'package:flowers_app/Features/auth/presentation/sign_in/widgets/login_button.dart';
import 'package:flowers_app/Features/auth/presentation/sign_in/widgets/remember_me_row.dart';
import 'package:flowers_app/Features/auth/presentation/sign_in/widgets/sign_up_row.dart';
import 'package:flowers_app/core/app_router/app_router.dart';
import 'package:flowers_app/core/constants/app_colors.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flowers_app/core/helpers/form_validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginScreenBody extends StatefulWidget {
  const LoginScreenBody({super.key});

  @override
  State<LoginScreenBody> createState() => _LoginScreenBodyState();
}

class _LoginScreenBodyState extends State<LoginScreenBody> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isPasswordVisible = false;
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<LoginViewModel>();

    return SingleChildScrollView(
      child: Column(
        children: [
          Form(
            key: _formKey,
            autovalidateMode: _autoValidateMode,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),

              child: BlocListener<LoginViewModel, LoginState>(
                listenWhen: (previous, current) {
                  return previous.loginState != current.loginState;
                },
                listener: (context, state) {
                  final loginState = state.loginState;

                  if (loginState?.data != null) {
                    context.goNamed(Routes.homeName);
                  } else if (loginState?.errorMessage != null) {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(loginState!.errorMessage!),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },

                child: BlocBuilder<LoginViewModel, LoginState>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24),
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) =>
                                FormValidators.validateEmail(context, value),
                            controller: _emailController,
                            onChanged: (value) {
                              viewModel.doIntent(UserTypingEvent());
                            },
                            style: Theme.of(context).textTheme.bodySmall,
                            decoration: InputDecoration(
                              labelText: context.l10n.emailLabel,
                              hintText: context.l10n.emailHint,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                            ),
                          ),
                        ),
                        TextFormField(
                          textInputAction: TextInputAction.done,
                          validator: (value) =>
                              FormValidators.validateLoginPassword(
                                context,
                                value,
                              ),
                          obscureText: !_isPasswordVisible,
                          controller: _passwordController,
                          onChanged: (value) {
                            viewModel.doIntent(UserTypingEvent());
                          },
                          style: Theme.of(context).textTheme.bodySmall,
                          decoration: InputDecoration(
                            labelText: context.l10n.passwordLabel,
                            hintText: context.l10n.passwordHint,
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            helperText: ' ',
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                              icon: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: AppColors.gray,
                              ),
                            ),
                          ),
                        ),
                        RememberMeRow(
                          rememberMe: state.isRememberMe,
                          onChanged: (value) {
                            viewModel.doIntent(ToggleRememberMeEvent());
                          },
                          onForgotPassword: () {
                            context.pushNamed(Routes.forgetPasswordName);
                          },
                        ),
                        if (state.loginState?.isLoading == true)
                          const Padding(
                            padding: EdgeInsets.only(top: 24),
                            child: CircularProgressIndicator(),
                          )
                        else
                          LoginButton(
                            onPressed: () {
                              setState(() {
                                _autoValidateMode = AutovalidateMode.always;
                              });

                              if (_formKey.currentState?.validate() ?? false) {
                                viewModel.doIntent(
                                  LoginButtonClickedEvent(
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                  ),
                                );
                              }
                            },
                          ),
                        GuestButton(
                          onPressed: () {
                            viewModel.doIntent(GuestLoginClickedEvent());
                          },
                        ),
                        const SignUpRow(),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
