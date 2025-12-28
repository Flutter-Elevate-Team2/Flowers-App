import 'package:flowers_app/Features/auth/api/api_client/auth_api.dart';
import 'package:flowers_app/Features/auth/api/auth_data_source_imple/auth_remote_data_source_imple.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/request/forget_password_request.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/request/reset_password_request.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/request/verify_password_request.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/responce/forget_password_response.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/responce/reset_password_response.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/responce/verify_password_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_remote_data_source_imple_test.mocks.dart';

@GenerateMocks([AuthApi])
void main() {
  late AuthRemoteDataSourceImple dataSource;
  late MockAuthApi mockAuthApi;

  setUp(() {
    mockAuthApi = MockAuthApi();
    dataSource = AuthRemoteDataSourceImple(mockAuthApi);
  });

  // ===========================================================================
  // 1. Test for Forget Password
  // ===========================================================================
  group('forgetPassword', () {
    final tRequest = ForgetPasswordRequest(email: "test@test.com");
    final tResponse = ForgetPasswordResponse(
      message: "Email sent",
      info: "Check inbox",
    );

    test(
      'should call AuthApi.forgetPassword and return ForgetPasswordResponse',
      () async {
        // ARRANGE
        when(
          mockAuthApi.forgetPassword(any),
        ).thenAnswer((_) async => tResponse);

        // ACT
        final result = await dataSource.forgetPassword(tRequest);

        // ASSERT
        expect(result, tResponse);
        verify(mockAuthApi.forgetPassword(tRequest)).called(1);
      },
    );

    test('should throw exception when API fails', () async {
      // ARRANGE
      when(mockAuthApi.forgetPassword(any)).thenThrow(Exception('API Error'));

      // ACT
      final call = dataSource.forgetPassword;

      // ASSERT
      expect(() => call(tRequest), throwsException);
    });
  });

  // ===========================================================================
  // 2. Test for Verify Password (Reset Code)
  // ===========================================================================
  group('verifyPassword', () {
    final tRequest = VerifyPasswordRequest(resetCode: "123456");
    final tResponse = VerifyPasswordResponse(status: "Success");

    test(
      'should call AuthApi.verifyPassword and return VerifyPasswordResponse',
      () async {
        // ARRANGE
        when(
          mockAuthApi.verifyPassword(any),
        ).thenAnswer((_) async => tResponse);

        // ACT
        final result = await dataSource.verifyPassword(tRequest);

        // ASSERT
        expect(result, tResponse);
        verify(mockAuthApi.verifyPassword(tRequest)).called(1);
      },
    );

    test('should throw exception when API fails', () async {
      // ARRANGE
      when(
        mockAuthApi.verifyPassword(any),
      ).thenThrow(Exception('Invalid Code'));

      // ACT
      final call = dataSource.verifyPassword;

      // ASSERT
      expect(() => call(tRequest), throwsException);
    });
  });

  // ===========================================================================
  // 3. Test for Reset Password
  // ===========================================================================
  group('resetPassword', () {
    final tRequest = ResetPasswordRequest(
      email: "test@test.com",
      newPassword: "NewPass123",
    );
    final tResponse = ResetPasswordResponse(
      message: "Password Changed",
      token: "newToken123",
    );

    test(
      'should call AuthApi.resetPassword and return ResetPasswordResponse',
      () async {
        // ARRANGE
        when(mockAuthApi.resetPassword(any)).thenAnswer((_) async => tResponse);

        // ACT
        final result = await dataSource.resetPassword(tRequest);

        // ASSERT
        expect(result, tResponse);
        verify(mockAuthApi.resetPassword(tRequest)).called(1);
      },
    );

    test('should throw exception when API fails', () async {
      // ARRANGE
      when(mockAuthApi.resetPassword(any)).thenThrow(Exception('Server Error'));

      // ACT
      final call = dataSource.resetPassword;

      // ASSERT
      expect(() => call(tRequest), throwsException);
    });
  });
}
