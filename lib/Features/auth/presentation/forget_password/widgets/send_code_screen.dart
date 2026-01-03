import 'package:flowers_app/Features/auth/presentation/forget_password/widgets/resend_code_view_body.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

class SendCodeScreen extends StatelessWidget {
  const SendCodeScreen({
    super.key,
    required this.onPreviousPage,
    required this.onNextPage,
    this.errorMessage,
  });

  final VoidCallback onPreviousPage;
  final VoidCallback onNextPage;
  final String? errorMessage;

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
          onPressed: onPreviousPage,
        ),
        title: Text(context.l10n.passwordLabel),
      ),
      body: SendCodeScreenBody(
        onNextPage: onNextPage,
        errorMessage: errorMessage,
      ),
    );
  }
}
