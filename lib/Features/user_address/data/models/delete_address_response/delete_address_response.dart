import 'package:flowers_app/Features/user_address/data/models/edit_address_response/address.dart';
import 'package:json_annotation/json_annotation.dart';

part 'delete_address_response.g.dart';

@JsonSerializable()
class DeleteAddressResponse {
  String? message;
  List<Address>? address;

  DeleteAddressResponse({this.message, this.address});

  factory DeleteAddressResponse.fromJson(Map<String, dynamic> json) {
    return _$DeleteAddressResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$DeleteAddressResponseToJson(this);
}
