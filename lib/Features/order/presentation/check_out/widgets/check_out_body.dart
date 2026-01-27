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
import 'package:flowers_app/Features/order/presentation/check_out/widgets/check_out_section_wrapper.dart';
import 'package:flowers_app/Features/order/presentation/check_out/widgets/check_out_total_price.dart';
import 'package:flowers_app/Features/order/presentation/check_out/widgets/delivery_time_section.dart';
import 'package:flowers_app/Features/order/presentation/check_out/widgets/gift_section.dart';
import 'package:flowers_app/Features/order/presentation/check_out/widgets/payment_method_option.dart';
import 'package:flowers_app/Features/order/presentation/check_out/widgets/payment_method_section.dart';
import 'package:flowers_app/core/di/di.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flowers_app/core/widget/custom_button.dart';
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
    final viewModel = context.read<CheckoutViewModel>();
    return BlocProvider<CheckoutViewModel>(
      create: (_) => getIt<CheckoutViewModel>(),
      child: BlocConsumer<CheckoutViewModel, CheckoutStates>(
        listener: (context, state) {
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
          }

          if (state.cashResponse != null) {
            context.read<CartViewModel>().doIntent(ClearCartEvent());
            context.goNamed(Routes.thankYouName);
          }

          if (state.isPaymentCancelled) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text("Payment cancelled")));
          }

          if (state.redirectUrl != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => CreditCheckoutWebView(url: state.redirectUrl!),
              ),
            ).then((_) {
              viewModel.resetPaymentState();
            });
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                const DeliveryTimeSection(),
                const SizedBox(height: 24),
                AddressSection(
                  onAddressSelected: (address) {
                    setState(() {
                      selectedAddress = address;
                    });
                  },
                ),
                const SizedBox(height: 24),
                PaymentMethodSection(
                  selectedMethod: _selectedPaymentMethod,
                  onChanged: (method) {
                    setState(() {
                      _selectedPaymentMethod = method;
                    });
                  },
                ),
                const SizedBox(height: 24),
                const GiftSection(),
                const SizedBox(height: 24),
                Column(
                  children: [
                    const CheckoutTotalPrice(),
                    CheckOutSectionWrapper(
                      child: CustomButton(
                        title: context.l10n.placeOrder,
                        onPressed: state.isLoading || selectedAddress == null
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

                                if (_selectedPaymentMethod ==
                                    PaymentMethod.cash) {
                                  viewModel.doIntent(
                                    CashPaymentEvent(orderRequest),
                                  );
                                } else {
                                  viewModel.doIntent(
                                    CreditCardPaymentEvent(orderRequest),
                                  );
                                }
                              },
                      ),
                    ),
                    if (state.isLoading)
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(),
                      ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
