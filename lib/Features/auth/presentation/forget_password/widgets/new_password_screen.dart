import 'package:flowers_app/Features/auth/presentation/forget_password/widgets/new_password_screen_body.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

class NewPasswordScreen extends StatelessWidget {
  const NewPasswordScreen({
    super.key,
    required this.onPreviousPage,
    this.userEmail,
  });

  final VoidCallback onPreviousPage;
  final String? userEmail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 40,
        titleSpacing: 0,
        leading: IconButton(
          icon: const Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Icon(Icons.arrow_back_ios),
          ),
          onPressed: onPreviousPage,
        ),
        title: Text(context.l10n.passwordLabel),
      ),
      body: NewPasswordScreenBody(userEmail: userEmail),
    );
  }
}
