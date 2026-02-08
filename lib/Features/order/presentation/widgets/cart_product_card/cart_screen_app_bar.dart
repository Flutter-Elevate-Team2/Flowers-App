import 'package:flowers_app/core/constants/app_colors.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
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
        Row(
          children: [
            Icon(Icons.location_on_outlined ,color: AppColors.gray,),
            SizedBox(width: 8),
            Expanded(
                child: RichText(
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '${context.l10n.deliverTo} ',
                        style: Theme.of(context).textTheme.titleMedium
                      ),
                      TextSpan(
                          text: '2XVP+XC - Sheikh Zayed...',
                          style: Theme.of(context).textTheme.bodyMedium
                      ),
                    ],
                  ),
                )

            ),
            Icon(Icons.keyboard_arrow_down_sharp ,color: AppColors.gray,),
          ],
        ),
      ],
    );
  }
}
