import 'package:flowers_app/Features/auth/data/auth_data_source_contract/auth_remote_data_source_contract.dart';
import 'package:flowers_app/Features/auth/data/auth_repo_imple/auth_repo_imple.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/request/Forget_Password_Request.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/request/Reset_Password_Request.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/request/Verify_Password_Request.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/responce/Forget_Password_Responce.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/responce/Reset_Password_Responce.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/responce/Verify_Password_Responce.dart';

import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'auth_repo_imple_test.mocks.dart';
@GenerateMocks([AuthRemoteDataSourceContract])

void main() {
  late AuthRepoImple repository;
  late MockAuthRemoteDataSourceContract mockDataSource;

  setUp(() {
    mockDataSource = MockAuthRemoteDataSourceContract();
    repository = AuthRepoImple(mockDataSource);
  });

  group('AuthRepo Imple Tests', () {

    test('forgetPassword should return data from remote data source', () async {
      // Arrange
      final request = ForgetPasswordRequest(email: "test@gmail.com");
      final response = SuccessResponse(data: ForgetPasswordResponce(message: "success"));

      when(mockDataSource.forgetPassword(any)).thenAnswer((_) async => response);

      // Act
      final result = await repository.forgetPassword(request);

      // Assert
      expect(result, response);
      verify(mockDataSource.forgetPassword(request)).called(1);
    });

    test('resetPassword should return data from remote data source', () async {
      // Arrange
      final request = ResetPasswordRequest(email: "test@gmail.com", newPassword: "123");
      final response = SuccessResponse(data: ResetPasswordResponce(message: "success"));

      when(mockDataSource.resetPassword(any)).thenAnswer((_) async => response);

      // Act
      final result = await repository.resetPassword(request);

      // Assert
      expect(result, response);
      verify(mockDataSource.resetPassword(request)).called(1);
    });

    test('verifyPassword should return data from remote data source', () async {
      // Arrange
      final request = VerifyPasswordRequest(resetCode: "123456");
      final response = SuccessResponse(data: VerifyPasswordResponce(status: "success"));

      when(mockDataSource.verifyPassword(any)).thenAnswer((_) async => response);

      // Act
      final result = await repository.verifyPassword(request);

      // Assert
      expect(result, response);
      verify(mockDataSource.verifyPassword(request)).called(1);
    });
  });
}