import 'package:flowers_app/core/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flowers_app/Features/commerce/domain/entities/product_entities/product_entity.dart';
import 'package:flowers_app/Features/order/domain/entities/cart/cart_item_entity.dart';
import 'package:flowers_app/Features/order/domain/entities/checkout/user_orders_entity.dart';
import 'package:flowers_app/Features/order/presentation/orders/widgets/order_card.dart';

void main() {
  final OrdersEntity fakeOrder = OrdersEntity(
    orderNumber: '12345',
    totalPrice: 250,
    updatedAt: '2024-01-01',
    orderItems: [
      CartItemEntity(
        quantity: 1,
        product: ProductEntity(
          id: '1',
          title: 'Rose Bouquet',
          imgCover: '',
          slug: '',
          description: '',
          images: const [],
          price: 1500,
          priceAfterDiscount: 1400,
          quantity: 0,
          categoryId: '',
          occasionId: '',
          sold: 0,
          rateAvg: 0,
          rateCount: 0,
          isInWishlist: false,
          discount: 0,
        ),
      ),
    ],
  );

  testWidgets('OrderCard shows data and handles button tap', (tester) async {
    bool tapped = false;

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: OrderCard(
          order: fakeOrder,
          isCompleted: false,
          onButtonPressed: () => tapped = true,
        ),
      ),
    );

    final context = tester.element(find.byType(OrderCard));
    final l10n = AppLocalizations.of(context)!;

    expect(find.text('Rose Bouquet'), findsOneWidget);
    expect(find.textContaining('250'), findsOneWidget);
    expect(find.text(l10n.trackOrder), findsOneWidget);

    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    expect(tapped, isTrue);
  });
}
