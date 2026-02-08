import 'package:flowers_app/Features/user_address/domain/entities/address_entity.dart';

class AddressResponseEntity {
  final String message;
  final List<AddressEntity> addresses;

  AddressResponseEntity({
    required this.message,
    required this.addresses,
  });
}
