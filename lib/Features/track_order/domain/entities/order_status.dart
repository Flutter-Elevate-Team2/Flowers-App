import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

enum OrderStatus {
  receivedYourOrder('received_your_order'),
  preparingYourOrder('preparing_your_order'),
  outForDelivery('out_for_delivery'),
  delivered('delivered');

  final String firebaseValue;
  const OrderStatus(this.firebaseValue);

  String getDisplayName(BuildContext context) {
    switch (this) {
      case OrderStatus.receivedYourOrder:
        return context.l10n.receivedYourOrder;
      case OrderStatus.preparingYourOrder:
        return context.l10n.picked;
      case OrderStatus.outForDelivery:
        return context.l10n.outForDelivery;
      case OrderStatus.delivered:
        return context.l10n.delivered;
    }
  }

  String getNotificationBody(BuildContext context) {
    switch (this) {
      case OrderStatus.receivedYourOrder:
        return context.l10n.receivedYourOrder;
      case OrderStatus.preparingYourOrder:
        return context.l10n.preparingYourOrder;
      case OrderStatus.outForDelivery:
        return context.l10n.outForDelivery;
      case OrderStatus.delivered:
        return context.l10n.delivered;
    }
  }

  String getButtonText(BuildContext context) {
    switch (this) {
      case OrderStatus.receivedYourOrder:
        return context.l10n.receivedYourOrder;
      case OrderStatus.preparingYourOrder:
        return context.l10n.preparingYourOrder;
      case OrderStatus.outForDelivery:
        return context.l10n.outForDelivery;
      case OrderStatus.delivered:
        return context.l10n.delivered;
    }
  }

  OrderStatus? get next {
    final currentIndex = OrderStatus.values.indexOf(this);
    if (currentIndex < OrderStatus.values.length - 1) {
      return OrderStatus.values[currentIndex + 1];
    }
    return null;
  }

}
