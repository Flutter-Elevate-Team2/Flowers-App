import 'package:json_annotation/json_annotation.dart';

part 'edit_address_request.g.dart';

@JsonSerializable()
class EditAddressRequest {
  String? street;
  String? phone;
  String? city;
  String? lat;
  String? long;
  String? username;

  EditAddressRequest({
    this.street,
    this.phone,
    this.city,
    this.lat,
    this.long,
    this.username,
  });

  factory EditAddressRequest.fromJson(Map<String, dynamic> json) {
    return _$EditAddressRequestFromJson(json);
  }

  Map<String, dynamic> toJson() => _$EditAddressRequestToJson(this);
}
