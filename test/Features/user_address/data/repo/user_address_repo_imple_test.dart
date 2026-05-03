import 'package:flowers_app/Features/user_address/data/data_sources/user_address_remote_data_source_contract.dart';
import 'package:flowers_app/Features/user_address/data/models/address_response_model.dart';
import 'package:flowers_app/Features/user_address/data/repo/user_address_repo_imple.dart';
 import 'package:flowers_app/Features/user_address/domain/entities/address_response_entity.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

 @GenerateMocks([UserAddressRemoteDataSourceContract])
import 'user_address_repo_imple_test.mocks.dart';

void main() {
  late MockUserAddressRemoteDataSourceContract mockDataSource;
  late UserAddressRepoImple repo;

  setUp(() {
    mockDataSource = MockUserAddressRemoteDataSourceContract();
    repo = UserAddressRepoImple(mockDataSource);
  });

  group('UserAddressRepoImple Tests', () {
    final tResponseModel = AddressResponseModel(message: "Success", addresses: []);
    const tId = "123";

    test('getAddresses should return SuccessResponse when data source succeeds', () async {
      // Arrange
      when(mockDataSource.getAddresses()).thenAnswer((_) async => tResponseModel);

      // Act
      final result = await repo.getAddresses();

      // Assert
      expect(result, isA<SuccessResponse<AddressResponseEntity>>());
      verify(mockDataSource.getAddresses()).called(1);
    });

    test('deleteAddress should call remote data source with correct id', () async {
      // Arrange
      when(mockDataSource.deleteAddress(any)).thenAnswer((_) async => tResponseModel);

      // Act
      await repo.deleteAddress(tId);

      // Assert
      verify(mockDataSource.deleteAddress(tId)).called(1);
    });

    test('should return ErrorResponse when data source throws an exception', () async {
      // Arrange
       when(mockDataSource.getAddresses()).thenThrow(Exception("Network Error"));

      // Act
      final result = await repo.getAddresses();

      // Assert
      expect(result, isA<ErrorResponse<AddressResponseEntity>>());
    });
  });
}