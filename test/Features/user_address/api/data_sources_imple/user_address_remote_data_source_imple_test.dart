import 'package:flowers_app/Features/user_address/api/api_client/user_address_api.dart';
import 'package:flowers_app/Features/user_address/api/data_sources_imple/user_address_remote_data_source_imple.dart';
import 'package:flowers_app/Features/user_address/data/models/add_address_request.dart';
import 'package:flowers_app/Features/user_address/data/models/address_response_model.dart';
import 'package:flowers_app/Features/user_address/data/models/edit_address_request/edit_address_request.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'user_address_remote_data_source_imple_test.mocks.dart';

@GenerateMocks([UserAddressApi])
void main() {
  late UserAddressRemoteDataSourceImple dataSource;
  late MockUserAddressApi mockUserAddressApi;

  setUp(() {
    mockUserAddressApi = MockUserAddressApi();
    dataSource = UserAddressRemoteDataSourceImple(mockUserAddressApi);
  });

  group('UserAddressRemoteDataSourceImple', () {
    test('addAddress should return AddressResponseModel when API call is successful', () async {
      // Arrange
      final request = AddAddressRequest(street: 'Street 1');
      final responseModel = AddressResponseModel(message: 'Success');

      when(mockUserAddressApi.addAddress(request))
          .thenAnswer((_) async => responseModel);

      // Act
      final result = await dataSource.addAddress(request);

      // Assert
      expect(result, responseModel);
      verify(mockUserAddressApi.addAddress(request)).called(1);
    });

    test('getAddresses should return AddressResponseModel when API call is successful', () async {
      // Arrange
      final responseModel = AddressResponseModel(message: 'Success', addresses: []);

      when(mockUserAddressApi.getAddresses())
          .thenAnswer((_) async => responseModel);

      // Act
      final result = await dataSource.getAddresses();

      // Assert
      expect(result, responseModel);
      verify(mockUserAddressApi.getAddresses()).called(1);
    });

    test('editAddress should return AddressResponseModel when API call is successful', () async {
      // Arrange
      final request = EditAddressRequest(street: 'New Street');
      final id = '123';
      final responseModel = AddressResponseModel(message: 'Updated');

      when(mockUserAddressApi.editAddress(id, request))
          .thenAnswer((_) async => responseModel);

      // Act
      final result = await dataSource.editAddress(request, id);

      // Assert
      expect(result, responseModel);
      verify(mockUserAddressApi.editAddress(id, request)).called(1);
    });

    test('deleteAddress should return AddressResponseModel when API call is successful', () async {
      // Arrange
      final id = '123';
      final responseModel = AddressResponseModel(message: 'Deleted');

      when(mockUserAddressApi.deleteAddress(id))
          .thenAnswer((_) async => responseModel);

      // Act
      final result = await dataSource.deleteAddress(id);

      // Assert
      expect(result, responseModel);
      verify(mockUserAddressApi.deleteAddress(id)).called(1);
    });
  });
}
