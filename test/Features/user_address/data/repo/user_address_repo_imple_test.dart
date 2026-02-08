import 'package:flowers_app/Features/user_address/data/data_sources/user_address_remote_data_source_contract.dart';
import 'package:flowers_app/Features/user_address/data/models/add_address_request.dart';
import 'package:flowers_app/Features/user_address/data/models/address_dto.dart';
import 'package:flowers_app/Features/user_address/data/models/address_response_model.dart';
import 'package:flowers_app/Features/user_address/data/models/edit_address_request/edit_address_request.dart';
import 'package:flowers_app/Features/user_address/data/repo/user_address_repo_imple.dart';
import 'package:flowers_app/Features/user_address/domain/entities/address_response_entity.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'user_address_repo_imple_test.mocks.dart';

@GenerateMocks([UserAddressRemoteDataSourceContract])
void main() {
  late UserAddressRepoImple repo;
  late MockUserAddressRemoteDataSourceContract mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockUserAddressRemoteDataSourceContract();
    repo = UserAddressRepoImple(mockRemoteDataSource);
  });

  group('UserAddressRepoImple', () {
    group('addAddress', () {
      test('should return SuccessResponse with mapped Entity when Data Source succeeds', () async {
        // Arrange
        final request = AddAddressRequest(street: '123 St');
        final responseModel = AddressResponseModel(
          message: 'Address Added',
          addresses: [AddressDto(id: '1', street: '123 St', city: 'Cairo')],
        );

        when(mockRemoteDataSource.addAddress(request))
            .thenAnswer((_) async => responseModel);

        // Act
        final result = await repo.addAddress(request);

        // Assert
        expect(result, isA<SuccessResponse<AddressResponseEntity>>());

        final data = (result as SuccessResponse<AddressResponseEntity>).data;
        expect(data.message, 'Address Added');
        expect(data.addresses.first.city, 'Cairo'); // Verification of mapping

        verify(mockRemoteDataSource.addAddress(request)).called(1);
      });

      test('should return ErrorResponse when Data Source throws Exception', () async {
        // Arrange
        final request = AddAddressRequest(street: '123 St');
        when(mockRemoteDataSource.addAddress(request))
            .thenThrow(Exception('Network Error'));

        // Act
        final result = await repo.addAddress(request);

        // Assert
        expect(result, isA<ErrorResponse<AddressResponseEntity>>());
        verify(mockRemoteDataSource.addAddress(request)).called(1);
      });
    });

    group('getAddresses', () {
      test('should return SuccessResponse with list of addresses', () async {
        // Arrange
        final responseModel = AddressResponseModel(
          message: 'Success',
          addresses: [
            AddressDto(id: '1', city: 'Cairo'),
            AddressDto(id: '2', city: 'Alex'),
          ],
        );

        when(mockRemoteDataSource.getAddresses())
            .thenAnswer((_) async => responseModel);

        // Act
        final result = await repo.getAddresses();

        // Assert
        expect(result, isA<SuccessResponse<AddressResponseEntity>>());
        final data = (result as SuccessResponse<AddressResponseEntity>).data;
        expect(data.addresses.length, 2);
        verify(mockRemoteDataSource.getAddresses()).called(1);
      });
    });

    group('editAddress', () {
      test('should return SuccessResponse when update is successful', () async {
        // Arrange
        final request = EditAddressRequest(street: 'New St');
        final id = '1';
        final responseModel = AddressResponseModel(message: 'Updated');

        when(mockRemoteDataSource.editAddress(request, id))
            .thenAnswer((_) async => responseModel);

        // Act
        final result = await repo.editAddress(request, id);

        // Assert
        expect(result, isA<SuccessResponse<AddressResponseEntity>>());
        verify(mockRemoteDataSource.editAddress(request, id)).called(1);
      });
    });
  });
}
