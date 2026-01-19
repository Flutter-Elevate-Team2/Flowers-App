import 'package:flowers_app/Features/profile/data/data_sources/local_data_source_contract/profile_local_data_source_contract.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@Injectable(as: ProfileLocalDataSourceContract)
class ProfileLocalDataSourceImpl implements ProfileLocalDataSourceContract {
  final SharedPreferences _prefs;

  static const String _selectedImagePathKey = "selected_profile_image_path";

  ProfileLocalDataSourceImpl(this._prefs);

  @override
  Future<void> saveSelectedImagePath(String path) async {
    await _prefs.setString(_selectedImagePathKey, path);
  }

  @override
  Future<String?> getSelectedImagePath() async {
    return _prefs.getString(_selectedImagePathKey);
  }

  @override
  Future<void> clearSelectedImagePath() async {
    await _prefs.remove(_selectedImagePathKey);
  }
}
