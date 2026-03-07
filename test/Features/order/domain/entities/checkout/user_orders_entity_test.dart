import 'package:flowers_app/Features/commerce/domain/entities/product_entities/product_entity.dart';
import 'package:flowers_app/Features/order/domain/entities/cart/cart_item_entity.dart';
 import 'package:flowers_app/Features/order/domain/entities/checkout/shipping_address_entity.dart';
import 'package:flowers_app/Features/order/domain/entities/checkout/user_orders_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('OrdersEntity Comprehensive Tests', () {
     final tProduct = ProductEntity(
      id: 'prod_1',
      title: 'Red Roses Bouquet',
      slug: 'red-roses',
      description: 'Beautiful fresh roses',
      imgCover: 'cover.jpg',
      images: const ['img1.jpg', 'img2.jpg'],
      price: 150,
      priceAfterDiscount: 140,
      quantity: 10,
      categoryId: 'cat_1',
      occasionId: 'occ_1',
      sold: 5,
      rateAvg: 5,
      rateCount: 100,
      isInWishlist: false,
      discount: 10,
    );

    final tCartItem = CartItemEntity(
      id: 'item_1',
      product: tProduct,
      price: 150,
      quantity: 2,
    );

    const tShippingAddress = ShippingAddressEntity(
      street: '90th Street',
      city: 'New Cairo',
      phone: '0123456789',
      lat: '30.0444',
      long: '31.2357',
    );

    final tOrdersEntity = OrdersEntity(
      id: 'order_100',
      user: 'user_50',
      orderItems: [tCartItem],
      shippingAddress: tShippingAddress,
      totalPrice: 300.0,
      paymentType: 'Credit Card',
      isPaid: true,
      isDelivered: false,
      state: 'Processing',
      orderNumber: 'ORD-2024-XYZ',
      createdAt: '2024-05-01T10:00:00Z',
      updatedAt: '2024-05-01T12:00:00Z',
    );

    test('should support value equality for the entire object tree', () {
      // Arrange: إنشاء كائن مطابق تماماً في المحتوى لكنه مختلف في مكان الذاكرة
      final identicalOrder = OrdersEntity(
        id: 'order_100',
        user: 'user_50',
        orderItems: [
            CartItemEntity(
            id: 'item_1',
            product: tProduct,
            price: 150,
            quantity: 2,
          )
        ],
        shippingAddress: const ShippingAddressEntity(
          street: '90th Street',
          city: 'New Cairo',
          phone: '0123456789',
          lat: '30.0444',
          long: '31.2357',
        ),
        totalPrice: 300.0,
        paymentType: 'Credit Card',
        isPaid: true,
        isDelivered: false,
        state: 'Processing',
        orderNumber: 'ORD-2024-XYZ',
        createdAt: '2024-05-01T10:00:00Z',
        updatedAt: '2024-05-01T12:00:00Z',
      );

      // Assert: يجب أن يكونوا متساويين بفضل Equatable في كل المستويات
      expect(tOrdersEntity, equals(identicalOrder));
    });

    test('should NOT be equal if any property in ShippingAddress changes', () {
      // Arrange
      final orderWithDifferentAddress = OrdersEntity(
        id: 'order_100',
        shippingAddress: const ShippingAddressEntity(city: 'Alexandria'), // مدينة مختلفة
      );

      // Assert
      expect(tOrdersEntity, isNot(equals(orderWithDifferentAddress)));
    });

    test('should NOT be equal if any property in CartItem list changes', () {
      // Arrange: تغيير الكمية فقط داخل الـ CartItem
      final orderWithDifferentQuantity = OrdersEntity(
        id: 'order_100',
        orderItems: [
          tCartItem.copyWith(tProduct, 150, 3, 'item_1'), // الكمية أصبحت 3
        ],
      );

      // Assert
      expect(tOrdersEntity, isNot(equals(orderWithDifferentQuantity)));
    });

    test('props list should contain all 12 properties', () {
      // Assert
      expect(tOrdersEntity.props.length, 12);
      expect(tOrdersEntity.props, contains(tShippingAddress));
      expect(tOrdersEntity.props, contains('ORD-2024-XYZ'));
    });
  });
}