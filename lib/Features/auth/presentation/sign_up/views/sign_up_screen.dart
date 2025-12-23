import 'package:flowers_app/Features/auth/presentation/sign_up/view_model/sign_up_view_model.dart';
import 'package:flowers_app/Features/auth/presentation/sign_up/widgets/signup_screen_body.dart';
import 'package:flowers_app/core/di/di.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leadingWidth: 50,
          titleSpacing: 0, 
        title: Text((context).l10n.signUpTitle),
        leading: IconButton(
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(),
          onPressed: () {},
          icon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: const Icon(Icons.arrow_back_ios),
          ),
        ),
      ),

      body: BlocProvider(
        create: (context) => getIt<SignUpViewModel>(),
        child: SignupScreenBody(),
      ),
    );
  }
}
