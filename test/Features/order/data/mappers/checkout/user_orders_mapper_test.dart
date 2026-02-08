import 'package:flowers_app/Features/order/data/mappers/checkout/user_orders_mapper.dart';
import 'package:flowers_app/Features/order/data/models/cart/cart_item_dto.dart';
import 'package:flowers_app/Features/order/data/models/checkout/shipping_address_request.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flowers_app/Features/order/data/models/checkout/user_orders_dto.dart';
import 'package:flowers_app/Features/order/domain/entities/checkout/user_orders_entity.dart';

void main() {
  test('OrdersMapper maps Orders to OrdersEntity correctly', () {
    // Arrange
    final orderItem = CartItem(
      id: 'item1',
      quantity: 2,
      price: 100,
      product: null,
    );

    final shippingAddress = ShippingAddressRequest(
      street: 'Nile St',
      phone: '0123456789',
      city: 'Cairo',
      lat: "30.0",
      long: "31.2",
    );

    final dto = Orders(
      id: 'order123',
      user: 'user1',
      totalPrice: 200,
      paymentType: 'card',
      isPaid: true,
      isDelivered: false,
      state: 'processing',
      orderNumber: 'ORD-001',
      createdAt: '2026-02-04',
      updatedAt: '2026-02-04',
      orderItems: [orderItem],
      shippingAddress: shippingAddress,
    );

    // Act
    final entity = dto.toEntity();

    // Assert
    expect(entity, isA<OrdersEntity>());
    expect(entity.id, 'order123');
    expect(entity.user, 'user1');
    expect(entity.totalPrice, 200);
    expect(entity.paymentType, 'card');
    expect(entity.isPaid, true);
    expect(entity.isDelivered, false);
    expect(entity.state, 'processing');
    expect(entity.orderNumber, 'ORD-001');
    expect(entity.createdAt, '2026-02-04');
    expect(entity.updatedAt, '2026-02-04');
    expect(entity.orderItems, isNotEmpty);
    expect(entity.orderItems!.length, 1);
    expect(entity.orderItems!.first.id, 'item1');
    expect(entity.shippingAddress, isNotNull);
    expect(entity.shippingAddress!.street, 'Nile St');
    expect(entity.shippingAddress!.city, 'Cairo');
    expect(entity.shippingAddress!.phone, '0123456789');
  });
}
