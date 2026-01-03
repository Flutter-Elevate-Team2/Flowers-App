import 'package:dio/dio.dart';
import 'package:flowers_app/Features/auth/data/auth_data_source_contract/auth_local_data_source_contract.dart';
import 'package:flowers_app/Features/auth/data/auth_data_source_contract/auth_remote_data_source_contract.dart';
import 'package:flowers_app/Features/auth/data/auth_repo_imple/auth_repo_imple.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/request/forget_password_request/forget_password_request.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/responce/forget_password_responce.dart';
import 'package:flowers_app/Features/auth/data/models/login_models/login_response.dart';
import 'package:flowers_app/Features/auth/data/models/signup_models/signup_request.dart';
import 'package:flowers_app/Features/auth/data/models/signup_models/signup_response.dart';
import 'package:flowers_app/Features/auth/data/models/signup_models/user_dto.dart';
import 'package:flowers_app/Features/auth/domain/entities/forget_password_entity.dart';
import 'package:flowers_app/Features/auth/domain/entities/login_entity.dart';
import 'package:flowers_app/Features/auth/domain/entities/signup_entity.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_repo_imple_test.mocks.dart';

@GenerateMocks([AuthRemoteDataSourceContract, AuthLocalDataSourceContract])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AuthRepoImple authRepo;
  late MockAuthRemoteDataSourceContract mockRemoteDataSource;
  late MockAuthLocalDataSourceContract mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockAuthRemoteDataSourceContract();
    mockLocalDataSource = MockAuthLocalDataSourceContract();
    authRepo = AuthRepoImple(mockRemoteDataSource, mockLocalDataSource);
  });

  // --- Group 1: Sign Up ---
  group("SignUp Repo Function Test Cases", () {
    final tRequest = SignupRequest(
      firstName: "Ahmed",
      lastName: "Ali",
      email: "test@test.com",
      password: "P",
      rePassword: "P",
      phone: "010",
      gender: "male",
    );

    final tUserDto = UserDto(
      firstName: "Ahmed",
      lastName: "Ali",
      email: "test@test.com",
      phone: "010",
      gender: "male",
      id: "123",
    );

    final tSignupResponse = SignupResponse(
      message: "Success",
      token: "dummy_token",
      user: tUserDto,
    );

    test(
      "should return SuccessResponse<SignupEntity> when RemoteDataSource succeeds",
      () async {
        // ARRANGE
        when(
          mockRemoteDataSource.signUp(any),
        ).thenAnswer((_) async => tSignupResponse);

        // ACT
        final result = await authRepo.signUp(tRequest);

        // ASSERT
        expect(result, isA<SuccessResponse<SignupEntity>>());
        final successData = (result as SuccessResponse<SignupEntity>).data;
        expect(successData.token, tSignupResponse.token);
        verify(mockRemoteDataSource.signUp(tRequest)).called(1);
      },
    );

    test("should return ErrorResponse when DioException occurs", () async {
      // ARRANGE
      final dioError = DioException(
        requestOptions: RequestOptions(path: ''),
        response: Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 400,
          data: {'message': 'Error'},
        ),
        type: DioExceptionType.badResponse,
      );
      when(mockRemoteDataSource.signUp(any)).thenThrow(dioError);

      // ACT
      final result = await authRepo.signUp(tRequest);

      // ASSERT
      expect(result, isA<ErrorResponse>());
      verify(mockRemoteDataSource.signUp(tRequest)).called(1);
    });
  });

  // --- Group 2: Login ---
  group("Login Repo Function Test Cases", () {
    final tEmail = "test@test.com";
    final tPassword = "password123";
    final tIsRememberMe = true;

    final tUser = User(
      firstName: "Ahmed",
      lastName: "Ali",
      email: "test@test.com",
      phone: "010",
      gender: "male",
      id: "123",
    );

    final tLoginResponse = LoginResponse(
      message: "Success",
      token: "valid_token",
      user: tUser,
    );

    test(
      "should return SuccessResponse AND save token when RemoteDataSource succeeds",
      () async {
        // ARRANGE
        when(
          mockRemoteDataSource.login(any),
        ).thenAnswer((_) async => tLoginResponse);
        when(mockLocalDataSource.saveToken(any)).thenAnswer((_) async {});
        when(mockLocalDataSource.saveRememberMe(any)).thenAnswer((_) async {});

        // ACT
        final result = await authRepo.login(tEmail, tPassword, tIsRememberMe);

        // ASSERT
        expect(result, isA<SuccessResponse<LoginEntity>>());

        verify(mockRemoteDataSource.login(any)).called(1);

        verify(mockLocalDataSource.saveToken("valid_token")).called(1);
        verify(mockLocalDataSource.saveRememberMe(tIsRememberMe)).called(1);
      },
    );

    test(
      "should return ErrorResponse AND NOT save token when RemoteDataSource fails",
      () async {
        // ARRANGE
        final dioError = DioException(
          requestOptions: RequestOptions(path: ''),
          type: DioExceptionType.connectionError,
        );
        when(mockRemoteDataSource.login(any)).thenThrow(dioError);

        // ACT
        final result = await authRepo.login(tEmail, tPassword, tIsRememberMe);

        // ASSERT
        expect(result, isA<ErrorResponse>());

        verify(mockRemoteDataSource.login(any)).called(1);

        verifyNever(mockLocalDataSource.saveToken(any));
        verifyNever(mockLocalDataSource.saveRememberMe(any));
      },
    );
  });

  // --- Group 3: IsLoggedIn ---
  group("IsLoggedIn Repo Function Test Cases", () {
    test(
      "should return true when token exists AND rememberMe is true",
      () async {
        when(
          mockLocalDataSource.getToken(),
        ).thenAnswer((_) async => "some_token");
        when(mockLocalDataSource.getRememberMe()).thenAnswer((_) async => true);
        final result = await authRepo.isLoggedIn();
        expect(result, true);
      },
    );

    test("should return false when token is null", () async {
      when(mockLocalDataSource.getToken()).thenAnswer((_) async => null);
      when(mockLocalDataSource.getRememberMe()).thenAnswer((_) async => true);
      final result = await authRepo.isLoggedIn();
      expect(result, false);
    });

    test("should return false when rememberMe is false", () async {
      when(
        mockLocalDataSource.getToken(),
      ).thenAnswer((_) async => "some_token");
      when(mockLocalDataSource.getRememberMe()).thenAnswer((_) async => false);
      final result = await authRepo.isLoggedIn();
      expect(result, false);
    });
  });

  // --- Group 4: Forget Password ---
  group("ForgetPassword Repo Function Test Cases", () {
    final tRequest = ForgetPasswordRequest(email: "test@test.com");
    final tResponse = ForgetPasswordResponce(message: "Email sent");

    test(
      "should return SuccessResponse when RemoteDataSource succeeds",
      () async {
        when(
          mockRemoteDataSource.forgetPassword(any),
        ).thenAnswer((_) async => tResponse);
        final result = await authRepo.forgetPassword(tRequest);
        expect(result, isA<SuccessResponse<ForgetPasswordEntity>>());
      },
    );

    test("should return ErrorResponse when generic Exception occurs", () async {
      when(
        mockRemoteDataSource.forgetPassword(any),
      ).thenThrow(Exception("Fail"));
      final result = await authRepo.forgetPassword(tRequest);
      expect(result, isA<ErrorResponse>());
    });
  });
}
