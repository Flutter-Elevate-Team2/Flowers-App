import 'package:json_annotation/json_annotation.dart';

part 'add_address_request.g.dart';

@JsonSerializable()
class AddAddressRequest {
  final String? street;
  final String? phone;
  final String? city;
  final String? lat;
  final String? long;
  final String? username;

  AddAddressRequest({
    this.street,
    this.phone,
    this.city,
    this.lat,
    this.long,
    this.username,
  });

  Map<String, dynamic> toJson() => _$AddAddressRequestToJson(this);
}
