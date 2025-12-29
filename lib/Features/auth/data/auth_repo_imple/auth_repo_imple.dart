import 'package:flowers_app/Features/auth/data/auth_data_source_contract/auth_local_data_source_contract.dart';
import 'package:flowers_app/Features/auth/data/auth_data_source_contract/auth_remote_data_source_contract.dart';
import 'package:flowers_app/Features/auth/data/mappers/login_mappers.dart';
import 'package:flowers_app/Features/auth/data/models/login_models/login_request.dart';
import 'package:flowers_app/Features/auth/data/models/login_models/login_response.dart';
import 'package:flowers_app/Features/auth/domain/auth_repo_contract/auth_repo_contract.dart';
import 'package:flowers_app/Features/auth/domain/entities/login_entity.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flowers_app/core/helpers/api_execution_mixin.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRepoContract)
class AuthRepoImple with ApiExecutionMixin implements AuthRepoContract {
  final AuthRemoteDataSourceContract _remoteDataSource;
  final AuthLocalDataSourceContract _localDataSource;

  AuthRepoImple(this._remoteDataSource, this._localDataSource);

  @override
  Future<BaseResponse<LoginEntity>> login(
    String email,
    String password,
    bool isRememberMe,
  ) async {
    final request = LoginRequest(email: email, password: password);

    final result = await execute<LoginResponse, LoginEntity>(
      action: () async => await _remoteDataSource.login(request),
      mapper: (response) => response.toEntity(),
    );

    if (result is SuccessResponse<LoginEntity>) {
      final token = result.data.token;
      if (token != null && token.isNotEmpty) {
        await _localDataSource.saveToken(token);
        await _localDataSource.saveRememberMe(isRememberMe);
      }
    }
    return result;
  }

  @override
  Future<bool> isLoggedIn() async {
    final token = await _localDataSource.getToken();
    final isRememberMe = await _localDataSource.getRememberMe();

    return (token != null && token.isNotEmpty) && isRememberMe;
  }
}
