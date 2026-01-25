import 'package:flowers_app/Features/order/presentation/check_out/widgets/address_section.dart';
import 'package:flowers_app/Features/order/presentation/check_out/widgets/check_out_section_wrapper.dart';
import 'package:flowers_app/Features/order/presentation/check_out/widgets/check_out_total_price.dart';
import 'package:flowers_app/Features/order/presentation/check_out/widgets/delivery_time_section.dart';
import 'package:flowers_app/Features/order/presentation/check_out/widgets/gift_section.dart';
import 'package:flowers_app/Features/order/presentation/check_out/widgets/payment_method_option.dart';
import 'package:flowers_app/Features/order/presentation/check_out/widgets/payment_method_section.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flowers_app/core/widget/custom_button.dart';
import 'package:flutter/material.dart';

class CheckOutBody extends StatefulWidget {
  const CheckOutBody({super.key});

  @override
  State<CheckOutBody> createState() => _CheckOutBodyState();
}

class _CheckOutBodyState extends State<CheckOutBody> {
  PaymentMethod _selectedPaymentMethod = PaymentMethod.cash;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const DeliveryTimeSection(),
          const SizedBox(height: 24),
          const AddressSection(),
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
                  onPressed: () {
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
