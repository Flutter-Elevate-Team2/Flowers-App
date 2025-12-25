import 'package:flowers_app/Features/auth/presentation/forget_password/widgets/new_password_screen_body.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

class NewPasswordScreen extends StatelessWidget {
  const NewPasswordScreen({super.key, required this.onPreviousPage});

  final VoidCallback onPreviousPage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 40,

        titleSpacing: 0,
        leading: IconButton(
          icon: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: const Icon(Icons.arrow_back_ios),
          ),
          onPressed: onPreviousPage, 
        ),
        title: Text(context.l10n.passwordLabel),
      ),
      body: NewPasswordScreenBody(),
    );
  }
}
