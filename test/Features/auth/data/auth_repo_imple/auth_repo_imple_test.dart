import 'package:dio/dio.dart';
import 'package:flowers_app/Features/auth/data/auth_data_source_contract/auth_remote_data_source_contract.dart';
import 'package:flowers_app/Features/auth/data/auth_repo_imple/auth_repo_imple.dart';
import 'package:flowers_app/Features/auth/data/models/signup_models/signup_request.dart';
import 'package:flowers_app/Features/auth/data/models/signup_models/signup_response.dart';
import 'package:flowers_app/Features/auth/data/models/signup_models/user_dto.dart';
import 'package:flowers_app/Features/auth/domain/entities/signup_entity.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flowers_app/core/constants/error_strings.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_repo_imple_test.mocks.dart';

@GenerateMocks([AuthRemoteDataSourceContract])
void main() {
  late AuthRepoImple authRepo;
  late MockAuthRemoteDataSourceContract mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockAuthRemoteDataSourceContract();
    authRepo = AuthRepoImple(mockRemoteDataSource);
  });

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

    test(
      "should return ErrorResponse with backend message when DioException occurs",
      () async {
        // ARRANGE
        final dioError = DioException(
          requestOptions: RequestOptions(path: ''),
          response: Response(
            requestOptions: RequestOptions(path: ''),
            statusCode: 400,
            data: {'message': 'Email already exists'},
          ),
          type: DioExceptionType.badResponse,
        );

        when(mockRemoteDataSource.signUp(any)).thenThrow(dioError);

        // ACT
        final result = await authRepo.signUp(tRequest);

        // ASSERT
        expect(result, isA<ErrorResponse>());
        expect((result as ErrorResponse).errorMessage, 'Email already exists');
      },
    );

    test(
      "should return ErrorResponse with ErrorStrings.unknownError when generic Exception occurs",
      () async {
        // ARRANGE
        when(
          mockRemoteDataSource.signUp(any),
        ).thenThrow(Exception("Unexpected error"));

        // ACT
        final result = await authRepo.signUp(tRequest);

        // ASSERT
        expect(result, isA<ErrorResponse>());
        expect(
          (result as ErrorResponse).errorMessage,
          ErrorStrings.unknownError,
        );
      },
    );
  });
}
