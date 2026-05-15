abstract class AuthLocalDataSourceContract {
  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<void> saveUserId(String userId);
  Future<String?> getUserId();
  Future<void> saveRememberMe(bool value);
  Future<bool> getRememberMe();
  Future<void> clearUserData();
}
