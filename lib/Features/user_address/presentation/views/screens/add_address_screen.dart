import 'package:flowers_app/Features/user_address/domain/entities/address_entity.dart';
import 'package:flowers_app/Features/user_address/presentation/views/widgets/add_address_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddAddressScreen extends StatelessWidget {
  final AddressEntity? addressToEdit;

  const AddAddressScreen({super.key, this.addressToEdit});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 50,
        titleSpacing: 0,
        title: Text(addressToEdit != null ? "Edit Address" : "Add Address"),
        leading: IconButton(
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          onPressed: () {
            context.pop();
          },
          icon: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.arrow_back_ios),
          ),
        ),
      ),
      body: AddAddressScreenBody(addressToEdit: addressToEdit),
    );
  }
}
