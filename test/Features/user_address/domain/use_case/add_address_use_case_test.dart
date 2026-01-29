import 'package:flowers_app/Features/user_address/data/models/add_address_request.dart';
import 'package:flowers_app/Features/user_address/domain/entities/address_response_entity.dart';
import 'package:flowers_app/Features/user_address/domain/repo/user_address_repo_contract.dart';
import 'package:flowers_app/Features/user_address/domain/use_case/add_address_use_case.dart'; // تأكد من المسار
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../use_cases/user_address_use_case_test.mocks.dart';

@GenerateMocks([UserAddressRepoContract])
void main() {
  late AddAddressUseCase useCase;
  late MockUserAddressRepoContract mockRepo;

  setUpAll(() {
    final dummyEntity = AddressResponseEntity(message: '', addresses: []);
    final dummyResponse = SuccessResponse<AddressResponseEntity>(data: dummyEntity);

    provideDummy<BaseResponse<AddressResponseEntity>>(dummyResponse);
  });

  setUp(() {
    mockRepo = MockUserAddressRepoContract();
    useCase = AddAddressUseCase(mockRepo);
  });

  group('AddAddressUseCase', () {
    test('should return SuccessResponse when repo returns success', () async {
      // Arrange
      final request = AddAddressRequest(street: '123 St');
      final responseEntity = AddressResponseEntity(message: 'Added', addresses: []);
      final successResponse = SuccessResponse(data: responseEntity);

      when(mockRepo.addAddress(request))
          .thenAnswer((_) async => successResponse);

      // Act
      final result = await useCase(request);

      // Assert
      expect(result, isA<SuccessResponse<AddressResponseEntity>>());
      expect((result as SuccessResponse).data, responseEntity);
      verify(mockRepo.addAddress(request)).called(1);
    });

    test('should return ErrorResponse when repo returns error', () async {
      // Arrange
      final request = AddAddressRequest(street: '123 St');
      final errorResponse = ErrorResponse<AddressResponseEntity>(errorMessage: 'Failed');

      when(mockRepo.addAddress(request))
          .thenAnswer((_) async => errorResponse);

      // Act
      final result = await useCase(request);

      // Assert
      expect(result, isA<ErrorResponse<AddressResponseEntity>>());
      expect((result as ErrorResponse).errorMessage, 'Failed');
      verify(mockRepo.addAddress(request)).called(1);
    });
  });
}
