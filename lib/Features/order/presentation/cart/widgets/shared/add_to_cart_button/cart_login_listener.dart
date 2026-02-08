import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flowers_app/Features/order/presentation/cart/view_model/cart_events.dart';
import 'package:flowers_app/Features/order/presentation/cart/view_model/cart_states.dart';
import 'package:flowers_app/Features/order/presentation/cart/widgets/shared/add_to_cart_button/login_required_dialog.dart';
import 'package:flowers_app/Features/order/presentation/cart/view_model/cart_view_model.dart';

class CartLoginListener extends StatelessWidget {
  final Widget child;

  const CartLoginListener({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CartViewModel, CartStates>(
      listenWhen: (prev, curr) =>
          prev.requiresLogin != curr.requiresLogin && curr.requiresLogin,
      listener: (context, state) {
        if (state.requiresLogin) {
          final cartViewModel = context.read<CartViewModel>();
          showDialog(
            context: context,
            builder: (_) => LoginRequiredDialog(content: context.l10n.pleaseLoginToAdd),
          ).then((_) {
            cartViewModel.doIntent(CartLoginHandledEvent());
          });
        }
      },
      child: child,
    );
  }
}
