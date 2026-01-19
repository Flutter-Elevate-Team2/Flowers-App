abstract class ProfileLocalDataSourceContract {
  Future<void> saveSelectedImagePath(String path);
  Future<String?> getSelectedImagePath();
  Future<void> clearSelectedImagePath();
}
