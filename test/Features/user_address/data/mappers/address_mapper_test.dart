import 'package:flowers_app/Features/user_address/data/mappers/address_mapper.dart'; // تأكد من استيراد ملف الـ extensions
import 'package:flowers_app/Features/user_address/data/models/address_dto.dart';
import 'package:flowers_app/Features/user_address/data/models/address_response_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Address Mapper Tests', () {

    group('AddressDtoMapper (toEntity)', () {
      test('should map DTO correctly to Entity when all fields are present', () {
        // Arrange
        final dto = AddressDto(
          id: '1',
          street: 'Test St',
          phone: '123456',
          city: 'Cairo',
          lat: '30.0',
          long: '31.0',
          username: 'User',
        );

        // Act
        final entity = dto.toEntity();

        // Assert
        expect(entity.id, '1');
        expect(entity.street, 'Test St');
        expect(entity.phone, '123456');
        expect(entity.city, 'Cairo');
        expect(entity.lat, '30.0');
        expect(entity.long, '31.0');
        expect(entity.username, 'User');
      });

      test('should handle null values by returning empty strings', () {
        // Arrange
        final dto = AddressDto(
          id: null,
          street: null,
          phone: null,
          city: null,
          lat: null,
          long: null,
          username: null,
        );

        // Act
        final entity = dto.toEntity();

        // Assert
        expect(entity.id, '');
        expect(entity.street, '');
        expect(entity.city, '');
        // وهكذا لباقي الحقول
      });
    });

    group('AddressResponseMapper (toEntity)', () {
      test('should map ResponseModel to Entity correctly with populated list', () {
        // Arrange
        final dto = AddressDto(id: '1', street: 'St');
        final responseModel = AddressResponseModel(
          message: 'Success',
          addresses: [dto],
        );

        // Act
        final entity = responseModel.toEntity();

        // Assert
        expect(entity.message, 'Success');
        expect(entity.addresses.length, 1);
        expect(entity.addresses.first.id, '1');
      });

      test('should handle null list by returning empty list', () {
        // Arrange
        final responseModel = AddressResponseModel(
          message: null,
          addresses: null,
        );

        // Act
        final entity = responseModel.toEntity();

        // Assert
        expect(entity.message, '');
        expect(entity.addresses, isEmpty);
      });
    });
  });
}
