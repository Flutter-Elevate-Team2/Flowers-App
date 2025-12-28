import 'package:flowers_app/Features/auth/api/auth_local_data_source_imple/auth_local_data_source_imple.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flowers_app/Features/auth/data/auth_data_source_contract/auth_local_data_source_contract.dart';

void main() {
  late SharedPreferences prefs;
  late AuthLocalDataSourceContract localDataSource;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});

    prefs = await SharedPreferences.getInstance();
    localDataSource = AuthLocalDataSourceImple(prefs);
  });

  group('AuthLocalDataSource Tests', () {
    test('saveToken should store token in SharedPreferences', () async {
      // Act
      await localDataSource.saveToken('test_token');

      // Assert
      final storedToken = prefs.getString('user_token');
      expect(storedToken, 'test_token');
    });

    test('getToken should return saved token', () async {
      // Arrange
      await prefs.setString('user_token', 'token_123');

      // Act
      final token = await localDataSource.getToken();

      // Assert
      expect(token, 'token_123');
    });

    test('saveRememberMe should store remember me value', () async {
      // Act
      await localDataSource.saveRememberMe(true);

      // Assert
      final rememberMe = prefs.getBool('is_remember_me');
      expect(rememberMe, true);
    });

    test('getRememberMe should return false if value not saved', () async {
      // Act
      final rememberMe = await localDataSource.getRememberMe();

      // Assert
      expect(rememberMe, false);
    });

    test('clearUserData should remove token and remember me', () async {
      // Arrange
      await prefs.setString('user_token', 'token');
      await prefs.setBool('is_remember_me', true);

      // Act
      await localDataSource.clearUserData();

      // Assert
      expect(prefs.getString('user_token'), null);
      expect(prefs.getBool('is_remember_me'), null);
    });
  });
}
