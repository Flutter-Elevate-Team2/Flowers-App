import 'package:flowers_app/Features/auth/data/auth_data_source_contract/auth_remote_data_source_contract.dart';
import 'package:flowers_app/Features/auth/data/auth_repo_imple/auth_repo_imple.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/request/Forget_password_request.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/request/Reset_password_request.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/request/Verify_password_request.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/responce/Forget_password_responce.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/responce/Reset_password_responce.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/responce/Verify_password_responce.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../data/auth_repo_imple/auth_repo_imple_test.mocks.dart';

// Generate Mock for the Data Source
@GenerateMocks([AuthRemoteDataSourceContract])


void main() {
  late AuthRepoImple repository;
  late MockAuthRemoteDataSourceContract mockDataSource;

  setUpAll(() {

    provideDummy<BaseResponse<ForgetPasswordResponce>>(
      SuccessResponse(data: ForgetPasswordResponce()),
    );
    provideDummy<BaseResponse<ResetPasswordResponce>>(
      SuccessResponse(data: ResetPasswordResponce()),
    );
    provideDummy<BaseResponse<VerifyPasswordResponce>>(
      SuccessResponse(data: VerifyPasswordResponce()),
    );
  });

  setUp(() {
    mockDataSource = MockAuthRemoteDataSourceContract();
    repository = AuthRepoImple(mockDataSource);
  });

  group('AuthRepoImple Tests', () {
    test('forgetPassword should return data from remote data source', () async {
      final tRequest = ForgetPasswordRequest(email: "test@gmail.com");
      final tResponse = SuccessResponse(data: ForgetPasswordResponce(message: "success"));

      when(mockDataSource.forgetPassword(any)).thenAnswer((_) async => tResponse);

      final result = await repository.forgetPassword(tRequest);

      expect(result, tResponse);
      verify(mockDataSource.forgetPassword(tRequest)).called(1);
    });

    test('resetPassword should return data from remote data source', () async {
      final tRequest = ResetPasswordRequest(email: "test@gmail.com", newPassword: "123");
      final tResponse = SuccessResponse(data: ResetPasswordResponce(message: "success"));

      when(mockDataSource.resetPassword(any)).thenAnswer((_) async => tResponse);

      final result = await repository.resetPassword(tRequest);

      expect(result, tResponse);
      verify(mockDataSource.resetPassword(tRequest)).called(1);
    });

    test('verifyPassword should return data from remote data source', () async {
      final tRequest = VerifyPasswordRequest(resetCode: "123456");
      final tResponse = SuccessResponse(data: VerifyPasswordResponce(status: "success"));

      when(mockDataSource.verifyPassword(any)).thenAnswer((_) async => tResponse);

      final result = await repository.verifyPassword(tRequest);

      expect(result, tResponse);
      verify(mockDataSource.verifyPassword(tRequest)).called(1);
    });
  });
}