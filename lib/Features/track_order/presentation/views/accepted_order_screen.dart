import 'package:flowers_app/Features/track_order/domain/entities/order_status.dart';
import 'package:flowers_app/Features/track_order/presentation/view_model/track_order_state.dart';
import 'package:flowers_app/Features/track_order/presentation/view_model/track_order_view_model.dart';
import 'package:flowers_app/core/app_router/app_router.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flowers_app/core/widget/custom_button.dart';
import 'package:flowers_app/gen/assets.gen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AcceptedOrderScreen extends StatelessWidget {
  final String orderId;
  const AcceptedOrderScreen({required this.orderId, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          child: const Icon(Icons.arrow_back_ios),
          onTap: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Lottie.asset(
                    Assets.lottie.paymentSuccess,
                    repeat: false,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  context.l10n.placedSuccessfully,
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
              ),
              BlocBuilder<OrderStatusViewModel, TrackOrderStatusState>(
                builder: (context, state) {
                  final order = state.orderState?.data;
                  final bool isAccepted =
                      order?.status == OrderStatus.accepted.name;
                   return CustomButton(
                    title: context.l10n.trackOrder,
                    onPressed: isAccepted
                        ? () {
                            context.pushReplacementNamed(
                              Routes.trackOrderName,
                              pathParameters: {'orderId': orderId},
                            );
                          }
                        : null,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
