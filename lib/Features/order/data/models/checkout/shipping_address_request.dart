import 'package:json_annotation/json_annotation.dart';

part 'shipping_address_request.g.dart';

@JsonSerializable()
class ShippingAddressRequest {
  final String street;
  final String phone;
  final String city;
  final String lat;
  final String long;

  ShippingAddressRequest({
    required this.street,
    required this.phone,
    required this.city,
    required this.lat,
    required this.long,
  });

  factory ShippingAddressRequest.fromJson(Map<String, dynamic> json) =>
      _$ShippingAddressRequestFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ShippingAddressRequestToJson(this);
}
