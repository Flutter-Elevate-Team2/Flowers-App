import 'package:flowers_app/Features/auth/data/models/forget_password/request/Reset_password_request.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/responce/Reset_password_responce.dart';
import 'package:flowers_app/Features/auth/domain/auth_repo_contract/auth_repo_contract.dart';
import 'package:flowers_app/Features/auth/domain/use_cases/reset_password_usecase.dart'; // Adjust path
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'forget_password_usecase_test.mocks.dart';

@GenerateMocks([AuthRepoContract])


void main() {
  late ResetPasswordUsecase usecase;
  late MockAuthRepoContract mockAuthRepoContract;

  setUpAll(() {
    provideDummy<BaseResponse<ResetPasswordResponce>>(
      SuccessResponse(data: ResetPasswordResponce()),
    );
  });

  setUp(() {
    mockAuthRepoContract = MockAuthRepoContract();
    usecase = ResetPasswordUsecase(mockAuthRepoContract);
  });

  group('ResetPasswordUsecase Tests', () {
    final request = ResetPasswordRequest(
        email: "test@gmail.com",
        newPassword: "password123"
    );
    final response = SuccessResponse(
        data: ResetPasswordResponce(message: "success")
    );

    test('should call resetPassword on repository and return successful response', () async {
      // Arrange
      when(mockAuthRepoContract.resetPassword(any))
          .thenAnswer((_) async => response);

      // Act
      final result = await usecase.resetPassword(request);

      // Assert
      expect(result, response);

      verify(mockAuthRepoContract.resetPassword(request)).called(1);
      verifyNoMoreInteractions(mockAuthRepoContract);
    });

    test('should return ErrorResponse when repository fails to reset password', () async {
      // Arrange
      final errorResponse = ErrorResponse<ResetPasswordResponce>(
          errorMessage: "reset code not verified"
      );
      when(mockAuthRepoContract.resetPassword(any))
          .thenAnswer((_) async => errorResponse);

      // Act
      final result = await usecase.resetPassword(request);

      // Assert
      expect(result, isA<ErrorResponse>());
      expect((result as ErrorResponse).errorMessage, "reset code not verified");
      verify(mockAuthRepoContract.resetPassword(request)).called(1);
    });
  });
}