import 'package:flowers_app/Features/order/data/models/checkout/shipping_address_request.dart';
import 'package:flowers_app/Features/order/domain/entities/checkout/shipping_address_entity.dart';

extension ShippingAddressResponseMapper on ShippingAddressRequest {
  ShippingAddressEntity toEntity() {
    return ShippingAddressEntity(
      street: street,
      phone: phone,
      city: city,
      lat: lat,
      long: long,
    );
  }
}
