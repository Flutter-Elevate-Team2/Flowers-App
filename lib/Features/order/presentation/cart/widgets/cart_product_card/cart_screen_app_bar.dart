import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flowers_app/core/widget/address_selector.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CartScreenAppBar extends StatelessWidget {
  final int? cartItems;
   const CartScreenAppBar({ this.cartItems ,super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          children: [
            GestureDetector(
              child: const Icon(Icons.arrow_back_ios),
              onTap: () {
                context.pop();
              },
            ),
            Text(
              context.l10n.cart,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              ' ($cartItems ${context.l10n.items})',
              style: Theme.of(context).textTheme.headlineMedium,
              ),
          ],
        ),
        SizedBox(height:8 ,),
        AddressSelector(),
      ],
    );
  }
}
