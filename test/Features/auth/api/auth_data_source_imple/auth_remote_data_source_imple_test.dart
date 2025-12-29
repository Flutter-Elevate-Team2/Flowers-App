import 'package:flowers_app/Features/auth/api/auth_data_source_imple/auth_remote_data_source_imple.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:flowers_app/Features/auth/api/api_client/auth_api.dart';
import 'package:flowers_app/Features/auth/data/models/login_models/login_request.dart';
import 'package:flowers_app/Features/auth/data/models/login_models/login_response.dart';

import 'auth_remote_data_source_imple_test.mocks.dart';

@GenerateMocks([AuthApi])
void main() {
  late AuthRemoteDataSourceImple remoteDataSource;
  late MockAuthApi mockAuthApi;

  setUp(() {
    mockAuthApi = MockAuthApi();
    remoteDataSource = AuthRemoteDataSourceImple(mockAuthApi);
  });

  group('AuthRemoteDataSource.login', () {
    final request = LoginRequest(
      email: 'malak@gmail.com',
      password: 'Elevate@123',
    );

    final response = LoginResponse(
      token: 'token',
      message: 'success',
      user: null,
    );

    test(
      'should call AuthApi.login once and return LoginResponse',
          () async {
        // Arrange
        when(mockAuthApi.login(any))
            .thenAnswer((_) async => response);

        // Act
        final result = await remoteDataSource.login(request);

        // Assert
        expect(result, equals(response)); // مش مجرد type
        verify(mockAuthApi.login(request)).called(1);
        verifyNoMoreInteractions(mockAuthApi);
      },
    );

    test(
      'should throw exception when AuthApi throws',
          () async {
        // Arrange
        when(mockAuthApi.login(any))
            .thenThrow(Exception('API Error'));

        // Act & Assert
        expect(
              () => remoteDataSource.login(request),
          throwsException,
        );
      },
    );
  });
}
