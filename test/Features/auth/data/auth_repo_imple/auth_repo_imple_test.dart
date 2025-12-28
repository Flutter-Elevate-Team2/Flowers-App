import 'package:flowers_app/Features/auth/data/auth_repo_imple/auth_repo_imple.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:flowers_app/Features/auth/data/auth_data_source_contract/auth_remote_data_source_contract.dart';
import 'package:flowers_app/core/base_response/base_response.dart';

import 'package:flowers_app/Features/auth/data/models/forget_password/request/forget_password_request.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/responce/forget_password_response.dart';
import 'package:flowers_app/Features/auth/domain/entities/forget_password_entity.dart';

import 'package:flowers_app/Features/auth/data/models/forget_password/request/reset_password_request.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/responce/reset_password_response.dart';
import 'package:flowers_app/Features/auth/domain/entities/reset_password_entity.dart';

import 'package:flowers_app/Features/auth/data/models/forget_password/request/verify_password_request.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/responce/verify_password_response.dart';
import 'package:flowers_app/Features/auth/domain/entities/verify_password_entity.dart';

import 'auth_repo_imple_test.mocks.dart';

@GenerateMocks([AuthRemoteDataSourceContract])
void main() {
  late AuthRepoImple authRepo;
  late MockAuthRemoteDataSourceContract mockDataSource;

  setUp(() {
    mockDataSource = MockAuthRemoteDataSourceContract();
    authRepo = AuthRepoImple(mockDataSource);
  });

  // ===========================================================================
  // 1. Test for Forget Password
  // ===========================================================================
  group('forgetPassword', () {
    final tRequest = ForgetPasswordRequest(email: "test@test.com");
    final tResponse = ForgetPasswordResponse(message: "Sent", info: "Check Spam");
    final tEntity = ForgetPasswordEntity(message: "Sent", info: "Check Spam");

    test('should return SuccessResponse<ForgetPasswordEntity> when DataSource succeeds', () async {
      // ARRANGE
      when(mockDataSource.forgetPassword(any)).thenAnswer((_) async => tResponse);

      // ACT
      final result = await authRepo.forgetPassword(tRequest);

      // ASSERT
      expect(result, isA<SuccessResponse<ForgetPasswordEntity>>());
      final successResult = result as SuccessResponse<ForgetPasswordEntity>;
      expect(successResult.data.message, tEntity.message);
      expect(successResult.data.info, tEntity.info);

      verify(mockDataSource.forgetPassword(tRequest)).called(1);
    });

    test('should return ErrorResponse when DataSource throws Exception', () async {
      // ARRANGE
      when(mockDataSource.forgetPassword(any)).thenThrow(Exception('Network Error'));

      // ACT
      final result = await authRepo.forgetPassword(tRequest);

      // ASSERT
      expect(result, isA<ErrorResponse<ForgetPasswordEntity>>());
      verify(mockDataSource.forgetPassword(tRequest)).called(1);
    });
  });

  // ===========================================================================
  // 2. Test for Reset Password
  // ===========================================================================
  group('resetPassword', () {
    final tRequest = ResetPasswordRequest(email: "test@test.com", newPassword: "Pass");
    final tResponse = ResetPasswordResponse(message: "Reset OK", token: "Token123");

    test('should return SuccessResponse<ResetPasswordEntity> when DataSource succeeds', () async {
      // ARRANGE
      when(mockDataSource.resetPassword(any)).thenAnswer((_) async => tResponse);

      // ACT
      final result = await authRepo.resetPassword(tRequest);

      // ASSERT
      expect(result, isA<SuccessResponse<ResetPasswordEntity>>());
      final successResult = result as SuccessResponse<ResetPasswordEntity>;
      expect(successResult.data.token, "Token123");

      verify(mockDataSource.resetPassword(tRequest)).called(1);
    });

    test('should return ErrorResponse when DataSource throws Exception', () async {
      // ARRANGE
      when(mockDataSource.resetPassword(any)).thenThrow(Exception('Server Error'));

      // ACT
      final result = await authRepo.resetPassword(tRequest);

      // ASSERT
      expect(result, isA<ErrorResponse<ResetPasswordEntity>>());
    });
  });

  // ===========================================================================
  // 3. Test for Verify Password
  // ===========================================================================
  group('verifyPassword', () {
    final tRequest = VerifyPasswordRequest(resetCode: "123456");
    final tResponse = VerifyPasswordResponse(status: "Verified");

    test('should return SuccessResponse<VerifyPasswordEntity> when DataSource succeeds', () async {
      // ARRANGE
      when(mockDataSource.verifyPassword(any)).thenAnswer((_) async => tResponse);

      // ACT
      final result = await authRepo.verifyPassword(tRequest);

      // ASSERT
      expect(result, isA<SuccessResponse<VerifyPasswordEntity>>());
      final successResult = result as SuccessResponse<VerifyPasswordEntity>;
      expect(successResult.data.status, "Verified");

      verify(mockDataSource.verifyPassword(tRequest)).called(1);
    });

    test('should return ErrorResponse when DataSource throws Exception', () async {
      // ARRANGE
      when(mockDataSource.verifyPassword(any)).thenThrow(Exception('Wrong Code'));

      // ACT
      final result = await authRepo.verifyPassword(tRequest);

      // ASSERT
      expect(result, isA<ErrorResponse<VerifyPasswordEntity>>());
    });
  });
}
