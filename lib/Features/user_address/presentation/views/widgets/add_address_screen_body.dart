import 'package:flowers_app/core/widget/custom_button.dart';
import 'package:flutter/material.dart';

class AddAddressScreenBody extends StatelessWidget {
  const AddAddressScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
      
        children: [
          Image(image: AssetImage("assets/images/add_address.png")),
          SizedBox(height: 24,),
          TextFormField(
            decoration: InputDecoration(
              labelText: "Address",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 16,),
          TextFormField(
            decoration: InputDecoration(
              labelText: "Phone Number",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 16,),
          TextFormField(
            decoration: InputDecoration(
              labelText: "Recipient name",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 24,),
          CustomButton(
          title: "save Address",
            onPressed: () {
              
            },
          ),
      
      
      
        ],
      ),
    );
  }
}