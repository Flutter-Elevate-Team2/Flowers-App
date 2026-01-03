import 'package:flowers_app/Features/auth/api/auth_data_source_imple/auth_remote_data_source_imple.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:flowers_app/Features/auth/api/api_client/auth_api.dart';
import 'package:flowers_app/Features/auth/data/models/signup_models/signup_request.dart';
import 'package:flowers_app/Features/auth/data/models/signup_models/signup_response.dart';

import 'auth_remote_data_source_imple_test.mocks.dart';


@GenerateMocks([AuthApi])
void main() {
  late AuthRemoteDataSourceImple dataSource;
  late MockAuthApi mockAuthApi;

  setUp(() {
    mockAuthApi = MockAuthApi();
    dataSource = AuthRemoteDataSourceImple(mockAuthApi);
  });

  final tRequest = SignupRequest(
      firstName: "Test", lastName: "User", email: "t@t.com",
      password: "P", rePassword: "P", phone: "123", gender: "male"
  );

  final tResponse = SignupResponse(message: "ok", token: "123");

  test('should call AuthApi.signUp and return SignupResponse', () async {
    // ARRANGE
    when(mockAuthApi.signUp(any)).thenAnswer((_) async => tResponse);

    // ACT
    final result = await dataSource.signUp(tRequest);

    // ASSERT
    expect(result, tResponse);
    verify(mockAuthApi.signUp(tRequest)).called(1);
  });

  test('should propagate exceptions from AuthApi', () async {
    // ARRANGE
    when(mockAuthApi.signUp(any)).thenThrow(Exception('API Error'));

    // ACT
    final call = dataSource.signUp;

    // ASSERT
    expect(() => call(tRequest), throwsException);
  });
}
