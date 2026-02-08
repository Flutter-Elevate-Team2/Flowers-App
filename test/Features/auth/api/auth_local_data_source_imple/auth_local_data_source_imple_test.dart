import 'package:flowers_app/Features/auth/api/auth_local_data_source_imple/auth_local_data_source_imple.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flowers_app/core/constants/api_constants.dart';

import 'auth_local_data_source_imple_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  late AuthLocalDataSourceImple dataSource;
  late MockSharedPreferences mockPrefs;

  setUp(() {
    mockPrefs = MockSharedPreferences();
    dataSource = AuthLocalDataSourceImple(mockPrefs);
  });

  test('saveToken should save token in shared preferences', () async {
    // arrange
    when(mockPrefs.setString(ApiConstants.tokenKey, 'token'))
        .thenAnswer((_) async => true);

    // act
    await dataSource.saveToken('token');

    // assert
    verify(mockPrefs.setString(ApiConstants.tokenKey, 'token')).called(1);
    verifyNoMoreInteractions(mockPrefs);
  });

  test('getToken should return token from shared preferences', () async {
    // arrange
    when(mockPrefs.getString(ApiConstants.tokenKey))
        .thenReturn('token');

    // act
    final result = await dataSource.getToken();

    // assert
    expect(result, 'token');
    verify(mockPrefs.getString(ApiConstants.tokenKey)).called(1);
    verifyNoMoreInteractions(mockPrefs);
  });

  test('saveRememberMe should save value in shared preferences', () async {
    // arrange
    when(mockPrefs.setBool('is_remember_me', true))
        .thenAnswer((_) async => true);

    // act
    await dataSource.saveRememberMe(true);

    // assert
    verify(mockPrefs.setBool('is_remember_me', true)).called(1);
    verifyNoMoreInteractions(mockPrefs);
  });

  test('getRememberMe should return false when value is null', () async {
    // arrange
    when(mockPrefs.getBool('is_remember_me')).thenReturn(null);

    // act
    final result = await dataSource.getRememberMe();

    // assert
    expect(result, false);
    verify(mockPrefs.getBool('is_remember_me')).called(1);
    verifyNoMoreInteractions(mockPrefs);
  });

  test('getRememberMe should return stored value when exists', () async {
    // arrange
    when(mockPrefs.getBool('is_remember_me')).thenReturn(true);

    // act
    final result = await dataSource.getRememberMe();

    // assert
    expect(result, true);
    verify(mockPrefs.getBool('is_remember_me')).called(1);
    verifyNoMoreInteractions(mockPrefs);
  });

  test('clearUserData should remove token and remember me keys', () async {
    // arrange
    when(mockPrefs.remove(ApiConstants.tokenKey))
        .thenAnswer((_) async => true);
    when(mockPrefs.remove('is_remember_me'))
        .thenAnswer((_) async => true);

    // act
    await dataSource.clearUserData();

    // assert
    verify(mockPrefs.remove(ApiConstants.tokenKey)).called(1);
    verify(mockPrefs.remove('is_remember_me')).called(1);
    verifyNoMoreInteractions(mockPrefs);
  });
}
