import 'package:flowers_app/Features/user_address/data/models/address_response_model.dart';
import 'package:flowers_app/Features/user_address/data/models/address_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AddressResponseModel Tests', () {

     final mockAddressJson = {
      'id': 1,
      'street': 'Tahrir Square',
     };

    test('Should map "addresses" key correctly using _readAddresses', () {
      final json = {
        'message': 'Success',
        'addresses': [mockAddressJson],
      };

      final model = AddressResponseModel.fromJson(json);

      expect(model.message, 'Success');
      expect(model.addresses, isA<List<AddressDto>>());
      expect(model.addresses?.length, 1);
    });

    test('Should map "address" (singular) key correctly using _readAddresses', () {
       final json = {
        'message': 'Success',
        'address': [mockAddressJson],
      };

      final model = AddressResponseModel.fromJson(json);

      expect(model.addresses?.length, 1);
      expect(model.addresses?.first, isA<AddressDto>());
    });

    test('Should return null for addresses if both keys are missing', () {
      final json = {
        'message': 'No addresses found',
      };

      final model = AddressResponseModel.fromJson(json);

      expect(model.addresses, isNull);
    });

    test('Should handle null message correctly', () {
      final json = {
        'addresses': [],
      };

      final model = AddressResponseModel.fromJson(json);

      expect(model.message, isNull);
      expect(model.addresses, isEmpty);
    });
  });
}