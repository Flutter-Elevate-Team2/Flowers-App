import 'package:flowers_app/Features/auth/data/models/forget_password/request/Forget_password_request.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/responce/Forget_password_responce.dart';
import 'package:flowers_app/Features/auth/domain/auth_repo_contract/auth_repo_contract.dart';
import 'package:flowers_app/Features/auth/domain/use_cases/forget_password_usecase.dart'; // Adjust path
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'forget_password_usecase_test.mocks.dart';


@GenerateMocks([AuthRepoContract])


void main() {
  late ForgetPasswordUsecase usecase;
  late MockAuthRepoContract mockAuthRepoContract;

  setUpAll(() {

    provideDummy<BaseResponse<ForgetPasswordResponce>>(
      SuccessResponse(data: ForgetPasswordResponce()),
    );
  });

  setUp(() {
    mockAuthRepoContract = MockAuthRepoContract();
    usecase = ForgetPasswordUsecase(mockAuthRepoContract);
  });

  group('ForgetPassword Usecase Tests', () {
    final request = ForgetPasswordRequest(email: "test@gmail.com");
    final response = SuccessResponse(data: ForgetPasswordResponce(message: "success"));

    test('should call forgetPassword on the repository and return the response', () async {
      // Arrange
      when(mockAuthRepoContract.forgetPassword(any))
          .thenAnswer((_) async => response);

      // Act
      final result = await usecase.forgetPassword(request);

      // Assert
      expect(result, response);

      verify(mockAuthRepoContract.forgetPassword(request)).called(1);
      verifyNoMoreInteractions(mockAuthRepoContract);
    });

    test('should return ErrorResponse when repository call fails', () async {
      // Arrange
      final errorResponse = ErrorResponse<ForgetPasswordResponce>(errorMessage: "Network Error");
      when(mockAuthRepoContract.forgetPassword(any))
          .thenAnswer((_) async => errorResponse);

      // Act
      final result = await usecase.forgetPassword(request);

      // Assert
      expect(result, isA<ErrorResponse>());
      expect((result as ErrorResponse).errorMessage, "Network Error");
      verify(mockAuthRepoContract.forgetPassword(request)).called(1);
    });
  });
}