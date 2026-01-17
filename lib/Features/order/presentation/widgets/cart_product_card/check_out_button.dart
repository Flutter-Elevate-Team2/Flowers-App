import 'package:flowers_app/core/extension/context_extension.dart';

import 'package:flutter/material.dart';

class CheckOutButton extends StatelessWidget {
  const CheckOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 14),
        ),
        child: Text(context.l10n.checkout, style: TextStyle(fontSize: 16)),
      ),
    );
  }
}
