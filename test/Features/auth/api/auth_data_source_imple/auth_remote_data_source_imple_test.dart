import 'package:flowers_app/Features/auth/api/api_client/auth_api.dart';
import 'package:flowers_app/Features/auth/api/auth_data_source_imple/auth_remote_data_source_imple.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/request/forget_password_request/forget_password_request.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/request/reset_password_request/reset_password_request.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/request/verify_password_request/verify_password_request.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/responce/forget_password_responce.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/responce/reset_password_responce.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/responce/verify_password_responce.dart';
import 'package:flowers_app/Features/auth/data/models/login_models/login_request.dart';
import 'package:flowers_app/Features/auth/data/models/login_models/login_response.dart';
import 'package:flowers_app/Features/auth/data/models/signup_models/signup_request.dart';
import 'package:flowers_app/Features/auth/data/models/signup_models/signup_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_remote_data_source_imple_test.mocks.dart';

@GenerateMocks([AuthApi])
void main() {
  late AuthRemoteDataSourceImple remoteDataSource;
  late MockAuthApi mockAuthApi;

  setUp(() {
    mockAuthApi = MockAuthApi();
    remoteDataSource = AuthRemoteDataSourceImple(mockAuthApi);
  });

  // ================= SIGN UP TEST =================
  group('signUp', () {
    final tRequest = SignupRequest(
      firstName: "A",
      lastName: "B",
      email: "a@b.com",
      password: "123",
      rePassword: "123",
      phone: "010",
      gender: "m",
    );
    final tResponse = SignupResponse(message: "Success", token: "token");

    test(
      'should return SignupResponse when AuthApi call is successful',
      () async {
        // ARRANGE
        when(mockAuthApi.signUp(tRequest)).thenAnswer((_) async => tResponse);

        // ACT
        final result = await remoteDataSource.signUp(tRequest);

        // ASSERT
        expect(result, tResponse);
        verify(mockAuthApi.signUp(tRequest)).called(1);
      },
    );

    test('should throw exception when AuthApi fails', () async {
      // ARRANGE
      when(mockAuthApi.signUp(any)).thenThrow(Exception("API Error"));

      // ACT & ASSERT
      expect(() => remoteDataSource.signUp(tRequest), throwsException);
    });
  });

  // ================= LOGIN TEST =================
  group('login', () {
    final tRequest = LoginRequest(email: "test@test.com", password: "password");
    final tResponse = LoginResponse(message: "Success", token: "token");

    test(
      'should return LoginResponse when AuthApi call is successful',
      () async {
        // ARRANGE
        when(mockAuthApi.login(tRequest)).thenAnswer((_) async => tResponse);

        // ACT
        final result = await remoteDataSource.login(tRequest);

        // ASSERT
        expect(result, tResponse);
        verify(mockAuthApi.login(tRequest)).called(1);
      },
    );
  });

  // ================= FORGET PASSWORD TEST =================
  group('forgetPassword', () {
    final tRequest = ForgetPasswordRequest(email: "test@test.com");
    final tResponse = ForgetPasswordResponce(message: "Sent");

    test(
      'should return ForgetPasswordResponce when AuthApi call is successful',
      () async {
        // ARRANGE
        when(
          mockAuthApi.forgetPassword(tRequest),
        ).thenAnswer((_) async => tResponse);

        // ACT
        final result = await remoteDataSource.forgetPassword(tRequest);

        // ASSERT
        expect(result, tResponse);
        verify(mockAuthApi.forgetPassword(tRequest)).called(1);
      },
    );
  });

  // ================= VERIFY PASSWORD TEST =================
  group('verifyPassword', () {
    final tRequest = VerifyPasswordRequest(resetCode: "123456");
    final tResponse = VerifyPasswordResponce(status: "Verified");

    test(
      'should return VerifyPasswordResponce when AuthApi call is successful',
      () async {
        // ARRANGE
        when(
          mockAuthApi.verifyPassword(tRequest),
        ).thenAnswer((_) async => tResponse);

        // ACT
        final result = await remoteDataSource.verifyPassword(tRequest);

        // ASSERT
        expect(result, tResponse);
        verify(mockAuthApi.verifyPassword(tRequest)).called(1);
      },
    );
  });

  // ================= RESET PASSWORD TEST =================
  group('resetPassword', () {
    final tRequest = ResetPasswordRequest(email: "a@a.com", newPassword: "new");
    final tResponse = ResetPasswordResponce(message: "Done");

    test(
      'should return ResetPasswordResponce when AuthApi call is successful',
      () async {
        // ARRANGE
        when(
          mockAuthApi.resetPassword(tRequest),
        ).thenAnswer((_) async => tResponse);

        // ACT
        final result = await remoteDataSource.resetPassword(tRequest);

        // ASSERT
        expect(result, tResponse);
        verify(mockAuthApi.resetPassword(tRequest)).called(1);
      },
    );
  });
}
