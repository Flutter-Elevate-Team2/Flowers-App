import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

enum OrderStatus {
  accepted('accepted'),              // 1. السائق قبل الطلب
  arrivedPickup('arrived_pickup'),   // 2. السائق وصل المتجر بيستلم (عند العميل: جاري التجهيز)
  outForDelivery('start_deliver'),   // 3. السائق اتحرك من المتجر (عند العميل: جاري التوصيل)
  arrivedUser('arrived_user'),       // 4. السائق وصل بيت العميل (عند العميل: المندوب وصل)
  delivered('delivered'),            // 5. السائق سلم الطلب (عند العميل: تم التسليم)
  completed('completed');
  final String firebaseValue;
  const OrderStatus(this.firebaseValue);

  int get stepIndex {
    switch (this) {
      case OrderStatus.accepted: return 0;
      case OrderStatus.arrivedPickup: return 1;
      case OrderStatus.outForDelivery: return 2;
      case OrderStatus.arrivedUser: return 3;
      case OrderStatus.delivered: return 4;
      case OrderStatus.completed: return 4;
    }
  }

  String getDisplayName(BuildContext context) {
    switch (this) {
      case OrderStatus.accepted:
        return context.l10n.accepted;
      case OrderStatus.arrivedPickup:
        return context.l10n.preparingYourOrder;
      case OrderStatus.outForDelivery:
        return context.l10n.outForDelivery;
      case OrderStatus.arrivedUser:
        return context.l10n.arrived;
      case OrderStatus.delivered:
      case OrderStatus.completed:
        return context.l10n.delivered;
    }
  }

  String getNotificationTitle(BuildContext context) {
    switch (this) {
      case OrderStatus.accepted:
        return context.l10n.notifAcceptedTitle;
      case OrderStatus.arrivedPickup:
        return context.l10n.notifArrivedPickupTitle;
      case OrderStatus.outForDelivery:
        return context.l10n.notifStartDeliverTitle;
      case OrderStatus.arrivedUser:
        return context.l10n.notifArrivedUserTitle;
      case OrderStatus.delivered:
      case OrderStatus.completed:
        return context.l10n.notifDeliveredTitle;
    }
  }

  String getNotificationBody(BuildContext context) {
    switch (this) {
      case OrderStatus.accepted:
        return context.l10n.notifAcceptedBody;
      case OrderStatus.arrivedPickup:
        return context.l10n.notifArrivedPickupBody;
      case OrderStatus.outForDelivery:
        return context.l10n.notifStartDeliverBody;
      case OrderStatus.arrivedUser:
        return context.l10n.notifArrivedUserBody;
      case OrderStatus.delivered:
      case OrderStatus.completed:
        return context.l10n.notifDeliveredBody;
    }
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
