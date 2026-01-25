import 'package:flowers_app/Features/user_address/data/models/delete_address_response/delete_address_response.dart';
import 'package:flowers_app/Features/user_address/data/models/edit_address_response/address.dart';
import 'package:flowers_app/Features/user_address/data/models/edit_address_response/edit_address_response.dart';
import 'package:flowers_app/Features/user_address/domain/entities/address_entity.dart';
import 'package:flowers_app/Features/user_address/domain/entities/address_response_entity.dart';

extension AddressDtoMapper on Address {
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

extension EditAddressResponseMapper on EditAddressResponse  {
  AddressResponseEntity toEntity() {
    return AddressResponseEntity(
      message: message ?? '',
      addresses: address?.map((e) => e.toEntity()).toList() ?? [],
    );
  }
}
extension DeleteAddressResponseMapper on DeleteAddressResponse  {
  AddressResponseEntity toEntity() {
    return AddressResponseEntity(
      message: message ?? '',
      addresses: address?.map((e) => e.toEntity()).toList() ?? [],

    );
  }
}