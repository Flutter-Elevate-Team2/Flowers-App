import 'package:flowers_app/Features/order/presentation/cart/view_model/cart_events.dart';
import 'package:flowers_app/Features/order/presentation/cart/view_model/cart_view_model.dart';
import 'package:flowers_app/core/app_router/app_router.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CreditCheckoutWebView extends StatelessWidget {
  final String url;
  const CreditCheckoutWebView({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (request) {
            final url = request.url;

            if (url.contains("success") || url.contains("allOrders")) {
              context.read<CartViewModel>().doIntent(ClearCartEvent());

              context.goNamed(Routes.thankYouName);

              return NavigationDecision.prevent;
            }

            if (url.contains("cancel") || url.contains("fail")) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Payment cancelled")),
              );
              Navigator.pop(context);
              return NavigationDecision.prevent;
            }

            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(url));

    return Scaffold(
      appBar: AppBar(title:  Text(context.l10n.creditCheckout)),
      body: WebViewWidget(controller: controller),
    );
  }
}
