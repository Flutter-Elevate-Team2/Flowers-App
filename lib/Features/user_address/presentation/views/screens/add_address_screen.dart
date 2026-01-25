import 'package:flowers_app/Features/user_address/presentation/views/widgets/add_address_screen_body.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddAddressScreen extends StatelessWidget {
  const AddAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leadingWidth: 50,
          titleSpacing: 0,
        title: Text( context.l10n.addressLabel),
        leading: IconButton(
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(),
          onPressed: () {
            context.pop();
          },
          icon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: const Icon(Icons.arrow_back_ios),
          ),
        ),
      ),
      body: AddAddressScreenBody(),
    );
  }
}
