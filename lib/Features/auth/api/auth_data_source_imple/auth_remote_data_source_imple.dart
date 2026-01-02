import 'package:flowers_app/Features/auth/api/api_client/auth_api.dart';
import 'package:flowers_app/Features/auth/data/auth_data_source_contract/auth_remote_data_source_contract.dart';
import 'package:flowers_app/Features/auth/data/models/signup_models/signup_request.dart';
import 'package:flowers_app/Features/auth/data/models/signup_models/signup_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRemoteDataSourceContract)
class AuthRemoteDataSourceImple implements AuthRemoteDataSourceContract {
  final AuthApi _authApi;

  AuthRemoteDataSourceImple(this._authApi);

  @override
  Future<SignupResponse> signUp(SignupRequest request) async {
    return _authApi.signUp(request);
  }
}
