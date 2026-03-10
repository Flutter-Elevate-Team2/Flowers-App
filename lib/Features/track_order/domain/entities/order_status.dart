import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

enum OrderStatus {
  accepted('accepted'),
  receivedYourOrder('arrived_pickup'),
  preparingYourOrder('start_deliver'),
  outForDelivery('arrived_user'),
  delivered('delivered'),
  completed('completed');

  final String firebaseValue;
  const OrderStatus(this.firebaseValue);

  String getDisplayName(BuildContext context) {
    switch (this) {
      case OrderStatus.accepted:
        return context.l10n.accepted;
      case OrderStatus.receivedYourOrder:
        return context.l10n.receivedYourOrder;
      case OrderStatus.preparingYourOrder:
        return context.l10n.preparingYourOrder;
      case OrderStatus.outForDelivery:
        return context.l10n.outForDelivery;
      case OrderStatus.delivered:
      case OrderStatus.completed: // ✅
        return context.l10n.delivered;
    }
  }

  String getNotificationBody(BuildContext context) {
    switch (this) {
      case OrderStatus.accepted:
        return context.l10n.accepted;
      case OrderStatus.receivedYourOrder:
        return context.l10n.receivedYourOrder;
      case OrderStatus.preparingYourOrder:
        return context.l10n.preparingYourOrder;
      case OrderStatus.outForDelivery:
        return context.l10n.outForDelivery;
      case OrderStatus.delivered:
      case OrderStatus.completed:
        return context.l10n.delivered;
    }
  }

  String getButtonText(BuildContext context) {
    switch (this) {
      case OrderStatus.accepted:
        return context.l10n.accepted;
      case OrderStatus.receivedYourOrder:
        return context.l10n.receivedYourOrder;
      case OrderStatus.preparingYourOrder:
        return context.l10n.preparingYourOrder;
      case OrderStatus.outForDelivery:
        return context.l10n.outForDelivery;
      case OrderStatus.delivered:
      case OrderStatus.completed:
        return context.l10n.delivered;
    }
  }

  OrderStatus? get next {
    final currentIndex = OrderStatus.values.indexOf(this);
    if (this == OrderStatus.delivered || this == OrderStatus.completed) return null;
    if (currentIndex < OrderStatus.values.length - 1) {
      return OrderStatus.values[currentIndex + 1];
    }
    return null;
  }
}

extension OrderStatusX on OrderStatus {
  static OrderStatus fromFirebase(String value) {
    return OrderStatus.values.firstWhere(
          (status) => status.firebaseValue == value,
      orElse: () => OrderStatus.accepted,
    );
  }
}
