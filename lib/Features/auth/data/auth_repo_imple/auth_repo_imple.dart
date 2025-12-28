import 'package:flowers_app/Features/auth/data/auth_data_source_contract/auth_remote_data_source_contract.dart';
import 'package:flowers_app/Features/auth/data/mappers/forget_password_mappers.dart';
import 'package:flowers_app/Features/auth/data/mappers/reset_password_mappers.dart';
import 'package:flowers_app/Features/auth/data/mappers/verify_password_mappers.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/request/forget_password_request.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/request/reset_password_request.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/request/verify_password_request.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/responce/forget_password_response.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/responce/reset_password_response.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/responce/verify_password_response.dart';
import 'package:flowers_app/Features/auth/domain/auth_repo_contract/auth_repo_contract.dart';
import 'package:flowers_app/Features/auth/domain/entities/forget_password_entity.dart';
import 'package:flowers_app/Features/auth/domain/entities/reset_password_entity.dart';
import 'package:flowers_app/Features/auth/domain/entities/verify_password_entity.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flowers_app/core/helpers/api_execution_mixin.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRepoContract)
class AuthRepoImple with ApiExecutionMixin implements AuthRepoContract {
  final AuthRemoteDataSourceContract _remoteDataSource;

  AuthRepoImple(this._remoteDataSource);

  @override
  Future<BaseResponse<ForgetPasswordEntity>> forgetPassword(
    ForgetPasswordRequest request,
  ) async {
    return execute<ForgetPasswordResponse, ForgetPasswordEntity>(
      action: () async => await _remoteDataSource.forgetPassword(request),
      mapper: (response) => response.toEntity(),
    );
  }

  @override
  Future<BaseResponse<ResetPasswordEntity>> resetPassword(
    ResetPasswordRequest request,
  ) async {
    return execute<ResetPasswordResponse, ResetPasswordEntity>(
      action: () async => await _remoteDataSource.resetPassword(request),
      mapper: (response) => response.toEntity(),
    );
  }

  @override
  Future<BaseResponse<VerifyPasswordEntity>> verifyPassword(
    VerifyPasswordRequest request,
  ) async {
    return execute<VerifyPasswordResponse, VerifyPasswordEntity>(
      action: () async => await _remoteDataSource.verifyPassword(request),
      mapper: (response) => response.toEntity(),
    );
  }
}
