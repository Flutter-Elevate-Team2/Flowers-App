import 'package:flowers_app/Features/user_address/data/models/address_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'address_response_model.g.dart';

@JsonSerializable()
class AddressResponseModel {
  final String? message;

  @JsonKey(name: 'addresses')
  final List<AddressDto>? addresses;

  AddressResponseModel({this.message, this.addresses});

  factory AddressResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AddressResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddressResponseModelToJson(this);
}
