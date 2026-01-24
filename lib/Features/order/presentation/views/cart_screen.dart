import 'package:flowers_app/Features/order/presentation/view_model/cart_states.dart';
import 'package:flowers_app/Features/order/presentation/view_model/cart_view_model.dart';
import 'package:flowers_app/Features/order/presentation/widgets/cart_body.dart';
import 'package:flowers_app/Features/order/presentation/widgets/cart_product_card/cart_screen_app_bar.dart';
import 'package:flowers_app/Features/order/presentation/widgets/cart_product_card/empty_cart_view.dart';
import 'package:flowers_app/Features/order/presentation/widgets/cart_product_card/guest_cart_view.dart';
import 'package:flowers_app/Features/order/presentation/widgets/cart_product_card/shimmer/cart_body_shimmer.dart';
import 'package:flowers_app/core/app_router/app_router.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flowers_app/core/helpers/error_mapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartViewModel, CartStates>(
      builder: (context, state) {
        final cartItems = state.cartData?.cart?.cartItems ?? [];

        if (state.isLoading) {
          return const Scaffold(body: CartBodyShimmer());
        }
        if (state.cartData == null) {
          return Scaffold(
            body: GuestCartView(
              onLogin: () {
                context.pushNamed(Routes.signInName);
              }, subTitle: context.l10n.pleaseLoginToContinue,
            ),
          );
        } else if (state.errorMessage != null) {
          return Scaffold(
            body: Center(
              child: Text(ErrorMapper.mapError(context, state.errorMessage!)),
            ),
          );
        }
        if (cartItems.isEmpty) {
          return const Scaffold(body: EmptyCartView());
        }
        return Scaffold(
          appBar: AppBar(
            title: CartScreenAppBar(
              cartItems: state.cartData?.numOfCartItems ?? 0,
            ),
          ),
          body: CartBody(cart: state.cartData?.cart),
        );
      },
    );
  }
}
