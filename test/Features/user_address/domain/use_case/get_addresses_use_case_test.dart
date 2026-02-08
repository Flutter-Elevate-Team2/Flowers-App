import 'package:flowers_app/Features/user_address/domain/entities/address_response_entity.dart';
import 'package:flowers_app/Features/user_address/domain/repo/user_address_repo_contract.dart';
import 'package:flowers_app/Features/user_address/domain/use_case/get_addresses_use_case.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'user_address_use_case_test.mocks.dart';

@GenerateMocks([UserAddressRepoContract])
void main() {
  late GetAddressesUseCase useCase;
  late MockUserAddressRepoContract mockRepo;

  setUpAll(() {
    final dummyEntity = AddressResponseEntity(message: '', addresses: []);
    final dummyResponse = SuccessResponse<AddressResponseEntity>(data: dummyEntity);

    provideDummy<BaseResponse<AddressResponseEntity>>(dummyResponse);
  });

  setUp(() {
    mockRepo = MockUserAddressRepoContract();
    useCase = GetAddressesUseCase(mockRepo);
  });

  group('GetAddressesUseCase', () {
    test('should return SuccessResponse when repo returns success', () async {
      // Arrange
      final responseEntity = AddressResponseEntity(message: 'List', addresses: []);
      final successResponse = SuccessResponse(data: responseEntity);

      when(mockRepo.getAddresses())
          .thenAnswer((_) async => successResponse);

      // Act
      final result = await useCase();

      // Assert
      expect(result, isA<SuccessResponse<AddressResponseEntity>>());
      verify(mockRepo.getAddresses()).called(1);
    });

    test('should return ErrorResponse when repo returns error', () async {
      // Arrange
      final errorResponse = ErrorResponse<AddressResponseEntity>(errorMessage: 'Network Error');

      when(mockRepo.getAddresses())
          .thenAnswer((_) async => errorResponse);

      // Act
      final result = await useCase();

      // Assert
      expect(result, isA<ErrorResponse<AddressResponseEntity>>());
      verify(mockRepo.getAddresses()).called(1);
    });
  });
}
