import 'package:json_annotation/json_annotation.dart';

import 'address.dart';

part 'edit_address_response.g.dart';

@JsonSerializable()
class EditAddressResponse {
  String? message;
  List<Address>? address;

  EditAddressResponse({this.message, this.address});

  factory EditAddressResponse.fromJson(Map<String, dynamic> json) {
    return _$EditAddressResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$EditAddressResponseToJson(this);
}
