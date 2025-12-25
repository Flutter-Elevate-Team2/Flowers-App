import 'package:flowers_app/Features/auth/presentation/forget_password/widgets/email_screen_body.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

class EmailScreen extends StatelessWidget {
  const EmailScreen({super.key, required this.onNextPage});

  final VoidCallback onNextPage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 40,

        titleSpacing: 0,
        leading: IconButton(
          icon: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Icon(Icons.arrow_back_ios),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(context.l10n.passwordLabel),
      ),
      body: EmailScreenBody(onNextPage: onNextPage),
    );
  }
}
