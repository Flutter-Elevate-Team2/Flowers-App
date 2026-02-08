import 'package:flowers_app/Features/order/data/models/checkout/order_request_dto.dart';
import 'package:flowers_app/Features/order/data/models/checkout/shipping_address_request.dart';
import 'package:flowers_app/Features/order/domain/entities/checkout/address_entity.dart';
import 'package:flowers_app/Features/order/presentation/cart/view_model/cart_events.dart';
import 'package:flowers_app/Features/order/presentation/cart/view_model/cart_view_model.dart';
import 'package:flowers_app/Features/order/presentation/check_out/view_model/checkout_events.dart';
import 'package:flowers_app/Features/order/presentation/check_out/view_model/checkout_states.dart';
import 'package:flowers_app/Features/order/presentation/check_out/view_model/checkout_view_model.dart';
import 'package:flowers_app/Features/order/presentation/check_out/views/credit_checkout_web_view.dart';
import 'package:flowers_app/Features/order/presentation/check_out/widgets/address_section.dart';
import 'package:flowers_app/Features/order/presentation/check_out/widgets/check_out_button.dart';
import 'package:flowers_app/Features/order/presentation/check_out/widgets/check_out_section_wrapper.dart';
import 'package:flowers_app/Features/order/presentation/check_out/widgets/check_out_total_price.dart';
import 'package:flowers_app/Features/order/presentation/check_out/widgets/delivery_time_section.dart';
import 'package:flowers_app/Features/order/presentation/check_out/widgets/gift_section.dart';
import 'package:flowers_app/Features/order/presentation/check_out/widgets/payment_method_option.dart';
import 'package:flowers_app/Features/order/presentation/check_out/widgets/payment_method_section.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flowers_app/core/app_router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CheckOutBody extends StatefulWidget {
  const CheckOutBody({super.key});

  @override
  State<CheckOutBody> createState() => _CheckOutBodyState();
}

class _CheckOutBodyState extends State<CheckOutBody> {
  PaymentMethod _selectedPaymentMethod = PaymentMethod.cash;
  AddressEntity? selectedAddress;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CheckoutViewModel, CheckoutStates>(
      listener: (context, state) {
        // Error message
        if (state.errorMessage != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
        }

        // Payment cancelled
        if (state.isPaymentCancelled) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(context.l10n.paymentCancelled)),
          );
        }

        // Cash payment success → navigate
        if (state.cashResponse != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.read<CartViewModel>().doIntent(ClearCartEvent());
            context.read<CheckoutViewModel>().resetPaymentState();
            context.goNamed(Routes.thankYouName);
          });
        }

        // Credit card payment → open WebView
        if (state.redirectUrl != null) {
          final viewModel = context.read<CheckoutViewModel>();
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            if (!mounted) return;
            await Navigator.push<bool>(
              context,
              MaterialPageRoute(
                builder: (_) => CreditCheckoutWebView(url: state.redirectUrl!),
              ),
            );

            viewModel.resetPaymentState();
          });
        }
      },
      builder: (context, state) {
        final viewModel = context.read<CheckoutViewModel>();
        final isLoading =
            state.isLoading ||
            state.redirectUrl != null ||
            state.cashResponse != null;

        return SingleChildScrollView(
          child: Column(
            children: [
              const DeliveryTimeSection(),
              const SizedBox(height: 24),
              AddressSection(
                onAddressSelected: (address) {
                  setState(() => selectedAddress = address);
                },
              ),
              const SizedBox(height: 24),
              PaymentMethodSection(
                selectedMethod: _selectedPaymentMethod,
                onChanged: (method) =>
                    setState(() => _selectedPaymentMethod = method),
              ),
              const SizedBox(height: 24),
              const GiftSection(),
              const SizedBox(height: 24),
              const CheckoutTotalPrice(),
              CheckOutSectionWrapper(
                child: CheckoutButton(
                  title: context.l10n.placeOrder,
                  isLoading: isLoading,
                  onPressed: selectedAddress == null
                      ? null
                      : () {
                          final orderRequest = OrderRequest(
                            shippingAddress: ShippingAddressRequest(
                              street: selectedAddress!.street,
                              city: selectedAddress!.city,
                              phone: selectedAddress!.phone,
                              lat: selectedAddress!.lat.toString(),
                              long: selectedAddress!.long.toString(),
                            ),
                          );

                          if (_selectedPaymentMethod == PaymentMethod.cash) {
                            viewModel.doIntent(CashPaymentEvent(orderRequest));
                          } else {
                            viewModel.doIntent(
                              CreditCardPaymentEvent(orderRequest),
                            );
                          }
                        },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
