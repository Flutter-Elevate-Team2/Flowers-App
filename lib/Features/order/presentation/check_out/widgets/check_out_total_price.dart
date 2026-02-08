import 'package:flowers_app/Features/order/presentation/check_out/widgets/check_out_section_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flowers_app/Features/order/presentation/cart/view_model/cart_view_model.dart';
import 'package:flowers_app/Features/order/presentation/cart/view_model/cart_states.dart';
import 'package:flowers_app/Features/order/presentation/cart/widgets/cart_product_card/total_price.dart';
import 'package:flowers_app/core/l10n/view_model/language_cubit.dart';

class CheckoutTotalPrice extends StatelessWidget {
  const CheckoutTotalPrice({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = context.read<LanguageCubit>().state.languageCode;

    return BlocBuilder<CartViewModel, CartStates>(
      buildWhen: (prev, curr) =>
          prev.cartData?.cart?.finalPrice != curr.cartData?.cart?.finalPrice,
      builder: (context, state) {
        final cart = state.cartData?.cart;

        if (cart == null) {
          return const SizedBox.shrink();
        }

        return CheckOutSectionWrapper(
          child: TotalPrice(
            subTotal: cart.totalPrice ?? 0,
            deliveryFee: cart.deliveryFee,
            totalPrice: cart.finalPrice,
            locale: locale,
          ),
        );
      },
    );
  }
}
