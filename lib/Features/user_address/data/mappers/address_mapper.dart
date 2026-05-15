import 'package:flowers_app/Features/user_address/data/models/address_dto.dart';
import 'package:flowers_app/Features/user_address/data/models/address_response_model.dart';
import 'package:flowers_app/Features/user_address/domain/entities/address_entity.dart';
import 'package:flowers_app/Features/user_address/domain/entities/address_response_entity.dart';

extension AddressDtoMapper on AddressDto {
  AddressEntity toEntity() {
    return AddressEntity(
      id: id ?? '',
      street: street ?? '',
      phone: phone ?? '',
      city: city ?? '',
      lat: lat ?? '',
      long: long ?? '',
      username: username ?? '',
    );
  }
}

extension AddressResponseMapper on AddressResponseModel {
  AddressResponseEntity toEntity() {
    return AddressResponseEntity(
      message: message ?? '',
      addresses: addresses?.map((e) => e.toEntity()).toList() ?? [],
    );
  }
}
