import 'package:flowers_app/Features/order/data/mappers/checkout/shipping_address_mapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flowers_app/Features/order/data/models/checkout/shipping_address_request.dart';
import 'package:flowers_app/Features/order/domain/entities/checkout/shipping_address_entity.dart';

void main() {
  test('ShippingAddressResponseMapper maps ShippingAddressRequest to ShippingAddressEntity correctly', () {
    // Arrange
    final dto = ShippingAddressRequest(
      street: 'Nile St',
      phone: '0123456789',
      city: 'Cairo',
      lat:"30.0",
      long: "31.2",
    );

    // Act
    final entity = dto.toEntity();

    // Assert
    expect(entity, isA<ShippingAddressEntity>());
    expect(entity.street, 'Nile St');
    expect(entity.phone, '0123456789');
    expect(entity.city, 'Cairo');
    expect(entity.lat, "30.0");
    expect(entity.long, "31.2");
  });
}
