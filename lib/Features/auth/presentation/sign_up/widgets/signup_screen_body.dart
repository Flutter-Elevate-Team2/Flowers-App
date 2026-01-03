import 'package:flowers_app/Features/auth/presentation/sign_up/widgets/sgin_up_form.dart';
import 'package:flutter/material.dart';


class SignupScreenBody extends StatelessWidget {


 const SignupScreenBody({super.key});
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          children: [
              const SizedBox(height: 24,),
             SignUpForm (),
          ],
        ),
      ),


      );
  }
}
