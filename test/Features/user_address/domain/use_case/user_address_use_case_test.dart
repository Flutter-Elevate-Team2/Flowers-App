import 'package:flowers_app/Features/user_address/data/models/edit_address_request/edit_address_request.dart';
import 'package:flowers_app/Features/user_address/domain/entities/address_entity.dart';
import 'package:flowers_app/Features/user_address/domain/entities/address_response_entity.dart';
import 'package:flowers_app/Features/user_address/domain/repo/user_address_repo_contract.dart';
import 'package:flowers_app/Features/user_address/domain/use_case/user_address_use_case.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'user_address_use_case_test.mocks.dart';

@GenerateMocks([UserAddressRepoContract])
void main() {
  provideDummy<BaseResponse<AddressResponseEntity>>(
    SuccessResponse(
      data: AddressResponseEntity(message: '', addresses: []),
    ),
  );

  late UserAddressUseCase useCase;
  late MockUserAddressRepoContract mockRepo;

  setUp(() {
    mockRepo = MockUserAddressRepoContract();
    useCase = UserAddressUseCase(mockRepo);
  });

  group('UserAddressUseCase - EditAddress Tests', () {
    test('editAddress should return SuccessResponse from repository', () async {
      // Arrange
      const addressId = '123';
      final editRequest = EditAddressRequest(
        street: 'New Street',
        phone: '1234567890',
        city: 'Cairo',
        lat: '30.0444',
        long: '31.2357',
        username: 'John Doe',
      );

      final addressEntity = AddressEntity(
        id: addressId,
        street: 'New Street',
        phone: '1234567890',
        city: 'Cairo',
        lat: '30.0444',
        long: '31.2357',
        username: 'John Doe',
      );

      final addressResponse = AddressResponseEntity(
        message: 'Address updated successfully',
        addresses: [addressEntity],
      );

      final successResponse = SuccessResponse<AddressResponseEntity>(
        data: addressResponse,
      );

      when(
        mockRepo.editAddress(editRequest, addressId),
      ).thenAnswer((_) async => successResponse);

      // Act
      final result = await useCase.editAddress(editRequest, addressId);

      // Assert
      expect(result, successResponse);
      expect(result, isA<SuccessResponse<AddressResponseEntity>>());
      verify(mockRepo.editAddress(editRequest, addressId)).called(1);
    });

    test(
      'editAddress should return ErrorResponse when repository fails',
      () async {
        // Arrange
        const addressId = '123';
        final editRequest = EditAddressRequest(
          street: 'New Street',
          phone: '1234567890',
          city: 'Cairo',
          lat: '30.0444',
          long: '31.2357',
          username: 'John Doe',
        );

        const errorMessage = 'Failed to update address';
        final errorResponse = ErrorResponse<AddressResponseEntity>(
          errorMessage: errorMessage,
        );

        when(
          mockRepo.editAddress(editRequest, addressId),
        ).thenAnswer((_) async => errorResponse);

        // Act
        final result = await useCase.editAddress(editRequest, addressId);

        // Assert
        expect(result, errorResponse);
        expect(result, isA<ErrorResponse<AddressResponseEntity>>());
        verify(mockRepo.editAddress(editRequest, addressId)).called(1);
      },
    );
  });

  group('UserAddressUseCase - DeleteAddress Tests', () {
    test(
      'deleteAddress should return SuccessResponse from repository',
      () async {
        // Arrange
        const addressId = '123';

        final addressResponse = AddressResponseEntity(
          message: 'Address deleted successfully',
          addresses: [],
        );

        final successResponse = SuccessResponse<AddressResponseEntity>(
          data: addressResponse,
        );

        when(
          mockRepo.deleteAddress(addressId),
        ).thenAnswer((_) async => successResponse);

        // Act
        final result = await useCase.deleteAddress(addressId);

        // Assert
        expect(result, successResponse);
        expect(result, isA<SuccessResponse<AddressResponseEntity>>());
        verify(mockRepo.deleteAddress(addressId)).called(1);
      },
    );

    test(
      'deleteAddress should return ErrorResponse when repository fails',
      () async {
        // Arrange
        const addressId = '123';
        const errorMessage = 'Failed to delete address';
        final errorResponse = ErrorResponse<AddressResponseEntity>(
          errorMessage: errorMessage,
        );

        when(
          mockRepo.deleteAddress(addressId),
        ).thenAnswer((_) async => errorResponse);

        // Act
        final result = await useCase.deleteAddress(addressId);

        // Assert
        expect(result, errorResponse);
        expect(result, isA<ErrorResponse<AddressResponseEntity>>());
        verify(mockRepo.deleteAddress(addressId)).called(1);
      },
    );
  });
}
