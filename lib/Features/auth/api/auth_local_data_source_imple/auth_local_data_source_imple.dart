import 'package:flowers_app/Features/auth/data/auth_data_source_contract/auth_local_data_source_contract.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@Injectable(as: AuthLocalDataSourceContract)
class AuthLocalDataSourceImple implements AuthLocalDataSourceContract {
  final SharedPreferences _prefs;

  // Keys for SharedPrefs
  static const String _tokenKey = "user_token";
  static const String _rememberMeKey = "is_remember_me";

  AuthLocalDataSourceImple(this._prefs);

  @override
  Future<void> saveToken(String token) async {
    await _prefs.setString(_tokenKey, token);
  }

  @override
  Future<String?> getToken() async {
    return _prefs.getString(_tokenKey);
  }

  @override
  Future<void> saveRememberMe(bool value) async {
    await _prefs.setBool(_rememberMeKey, value);
  }

  @override
  Future<bool> getRememberMe() async {
    return _prefs.getBool(_rememberMeKey) ?? false;
  }

  @override
  Future<void> clearUserData() async {
    await _prefs.remove(_tokenKey);
    await _prefs.remove(_rememberMeKey);
  }
}
