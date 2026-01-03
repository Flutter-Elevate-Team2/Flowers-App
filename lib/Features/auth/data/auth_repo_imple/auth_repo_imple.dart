import 'package:flowers_app/Features/auth/data/mappers/signup_mappers.dart';
import 'package:flowers_app/Features/auth/data/models/signup_models/signup_response.dart';
import 'package:injectable/injectable.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flowers_app/core/helpers/api_execution_mixin.dart';

import 'package:flowers_app/Features/auth/data/auth_data_source_contract/auth_remote_data_source_contract.dart';
import 'package:flowers_app/Features/auth/data/mappers/signup_mappers.dart';
import 'package:flowers_app/Features/auth/data/models/signup_models/signup_request.dart';
import 'package:flowers_app/Features/auth/data/models/signup_models/signup_response.dart';
import 'package:flowers_app/Features/auth/domain/auth_repo_contract/auth_repo_contract.dart';
import 'package:flowers_app/Features/auth/domain/entities/signup_entity.dart';

@Injectable(as: AuthRepoContract)
class AuthRepoImple with ApiExecutionMixin implements AuthRepoContract {
  final AuthRemoteDataSourceContract _remoteDataSource;

  AuthRepoImple(this._remoteDataSource);

  @override
  Future<BaseResponse<SignupEntity>> signUp(SignupRequest request) async {
    return execute<SignupResponse, SignupEntity>(
      action: () async => await _remoteDataSource.signUp(request),
      mapper: (response) => response.toEntity(),
    );
  }
}
