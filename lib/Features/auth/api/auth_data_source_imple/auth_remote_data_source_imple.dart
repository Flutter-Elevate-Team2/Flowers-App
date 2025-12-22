import 'package:flowers_app/Features/auth/api/api_client/auth_api.dart';
import 'package:flowers_app/Features/auth/data/auth_data_source_contract/auth_remote_data_source_contract.dart';
import 'package:flowers_app/Features/auth/data/models/login_models/login_request.dart';
import 'package:flowers_app/Features/auth/data/models/login_models/login_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRemoteDataSourceContract)
class AuthRemoteDataSourceImple implements AuthRemoteDataSourceContract {
  final AuthApi _authApi;

  AuthRemoteDataSourceImple(this._authApi);

  @override
  Future<LoginResponse> login(LoginRequest request) async {
    return await _authApi.login(request);
  }
}
