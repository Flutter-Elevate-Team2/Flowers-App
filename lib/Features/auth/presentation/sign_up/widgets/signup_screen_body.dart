import 'package:flowers_app/Features/auth/presentation/sign_up/widgets/sign_up_form.dart'; // Note the corrected filename import
import 'package:flutter/material.dart';

class SignupScreenBody extends StatelessWidget {
  const SignupScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 24),
            SignUpForm(),
          ],
        ),
      ),
    );
  }
}
