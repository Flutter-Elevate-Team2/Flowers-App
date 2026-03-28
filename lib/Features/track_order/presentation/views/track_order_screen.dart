import 'package:flowers_app/Features/track_order/presentation/view_model/track_order_event.dart';
import 'package:flowers_app/Features/track_order/presentation/view_model/track_order_view_model.dart';
import 'package:flowers_app/Features/track_order/presentation/widgets/track_order_body.dart';
import 'package:flowers_app/core/di/di.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class TrackOrderScreen extends StatelessWidget {
  final String orderId;

  const TrackOrderScreen({required this.orderId, super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (context) {
        final vm = getIt<OrderStatusViewModel>();
        vm.doIntent(context, FetchOrderDetailsEvent(orderId));
        return vm;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            child: const Icon(Icons.arrow_back_ios),
            onTap: () => context.pop(),
          ),
          title: Text(context.l10n.trackOrder),
        ),
        body: TrackOrderBody(),
      ),
    );
  }
}
