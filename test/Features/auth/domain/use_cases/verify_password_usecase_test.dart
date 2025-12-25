import 'package:flowers_app/Features/auth/data/models/forget_password/request/Verify_password_request.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/responce/Verify_password_responce.dart';
import 'package:flowers_app/Features/auth/domain/auth_repo_contract/auth_repo_contract.dart';
import 'package:flowers_app/Features/auth/domain/use_cases/verify_password_usecase.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'forget_password_usecase_test.mocks.dart';

@GenerateMocks([AuthRepoContract])


void main() {
  late VerifyPasswordUsecase usecase;
  late MockAuthRepoContract mockAuthRepoContract;

  setUpAll(() {
    provideDummy<BaseResponse<VerifyPasswordResponce>>(
      SuccessResponse(data: VerifyPasswordResponce()),
    );
  });

  setUp(() {
    mockAuthRepoContract = MockAuthRepoContract();
    usecase = VerifyPasswordUsecase(mockAuthRepoContract);
  });

  group('VerifyPasswordUsecase Tests', () {
    final tRequest = VerifyPasswordRequest(resetCode: "123456");
    final tResponse = SuccessResponse(
      data: VerifyPasswordResponce(status: "success"),
    );

    test('should call verifyPassword on repository and return successful response', () async {
      // Arrange
      when(mockAuthRepoContract.verifyPassword(any))
          .thenAnswer((_) async => tResponse);

      // Act
      final result = await usecase.verifyPassword(tRequest);

      // Assert
      expect(result, tResponse);

      verify(mockAuthRepoContract.verifyPassword(tRequest)).called(1);
      verifyNoMoreInteractions(mockAuthRepoContract);
    });

    test('should return ErrorResponse when repository returns failure', () async {
      // Arrange
      final errorResponse = ErrorResponse<VerifyPasswordResponce>(
        errorMessage: 'Reset code is invalid or has expired',
      );
      when(mockAuthRepoContract.verifyPassword(any))
          .thenAnswer((_) async => errorResponse);

      // Act
      final result = await usecase.verifyPassword(tRequest);

      // Assert
      expect(result, isA<ErrorResponse>());
      expect((result as ErrorResponse).errorMessage, 'Reset code is invalid or has expired');
      verify(mockAuthRepoContract.verifyPassword(tRequest)).called(1);
    });
  });
}