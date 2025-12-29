import 'package:dio/dio.dart';
import 'package:flowers_app/Features/auth/data/auth_data_source_contract/auth_local_data_source_contract.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flowers_app/Features/auth/data/auth_repo_imple/auth_repo_imple.dart';
import 'package:flowers_app/Features/auth/data/auth_data_source_contract/auth_remote_data_source_contract.dart';
import 'package:flowers_app/Features/auth/data/models/login_models/login_response.dart';
import 'package:flowers_app/Features/auth/domain/entities/login_entity.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flowers_app/core/constants/error_strings.dart';

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

    provideDummy<BaseResponse<LoginEntity>>(
      SuccessResponse(
        data: LoginEntity(token: '', message: '', user: null),
      ),
    );
  });

  group('Login Repo Tests', () {
    const email = 'malak@gmail.com';
    const password = 'Elevate@123';

    final tLoginResponse = LoginResponse(
      token: 'token',
      message: 'success',
      user: null,
    );

    test(
      'should return SuccessResponse<LoginEntity> when remote succeeds',
      () async {
        // Arrange
        when(
          mockRemoteDataSource.login(any),
        ).thenAnswer((_) async => tLoginResponse);

        // Act
        final result = await authRepo.login(email, password, true);

        // Assert
        expect(result, isA<SuccessResponse<LoginEntity>>());
        expect((result as SuccessResponse<LoginEntity>).data.token, 'token');
        verify(mockRemoteDataSource.login(any)).called(1);
        verify(mockLocalDataSource.saveToken('token')).called(1);
        verify(mockLocalDataSource.saveRememberMe(true)).called(1);
      },
    );

    test(
      'should return ErrorResponse with backend message when DioException occurs',
      () async {
        // Arrange
        final dioError = DioException(
          requestOptions: RequestOptions(path: ''),
          response: Response(
            requestOptions: RequestOptions(path: ''),
            statusCode: 400,
            data: {'message': 'Invalid credentials'},
          ),
          type: DioExceptionType.badResponse,
        );

        when(mockRemoteDataSource.login(any)).thenThrow(dioError);

        // Act
        final result = await authRepo.login(email, password, false);

        // Assert
        expect(result, isA<ErrorResponse>());
        expect((result as ErrorResponse).errorMessage, 'Invalid credentials');
      },
    );

    test(
      'should return ErrorResponse with unknownError when generic Exception occurs',
      () async {
        // Arrange
        when(
          mockRemoteDataSource.login(any),
        ).thenThrow(Exception('Unexpected error'));

        // Act
        final result = await authRepo.login(email, password, false);

        // Assert
        expect(result, isA<ErrorResponse>());
        expect(
          (result as ErrorResponse).errorMessage,
          ErrorStrings.unknownError,
        );
      },
    );
  });
}
