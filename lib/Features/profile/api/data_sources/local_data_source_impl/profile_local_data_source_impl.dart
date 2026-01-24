import 'package:flowers_app/Features/profile/data/data_sources/local_data_source_contract/profile_local_data_source_contract.dart';
import 'package:flowers_app/core/constants/api_constants.dart';
import 'package:flowers_app/core/controller/session_controller.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@Injectable(as: ProfileLocalDataSource)
class ProfileLocalDataSourceImpl implements ProfileLocalDataSource {
  final SharedPreferences _prefs;
  final SessionController _sessionController;
  static final String _tokenKey = ApiConstants.tokenKey;

  ProfileLocalDataSourceImpl(this._prefs, this._sessionController);

  @override
  Future<void> clearUserData() async {
    await _prefs.remove(_tokenKey);
    _sessionController.expireSession();
  }
}
