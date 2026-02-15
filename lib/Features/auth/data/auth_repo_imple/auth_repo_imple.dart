import 'package:flowers_app/Features/auth/data/auth_data_source_contract/auth_local_data_source_contract.dart';
import 'package:flowers_app/Features/auth/data/auth_data_source_contract/auth_remote_data_source_contract.dart';
import 'package:flowers_app/Features/auth/data/mappers/forget_password_mappers.dart';
import 'package:flowers_app/Features/auth/data/mappers/login_mappers.dart';
import 'package:flowers_app/Features/auth/data/mappers/reset_password_mappers.dart';
import 'package:flowers_app/Features/auth/data/mappers/signup_mappers.dart';
import 'package:flowers_app/Features/auth/data/mappers/verify_password_mappers.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/request/forget_password_request/forget_password_request.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/request/reset_password_request/reset_password_request.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/request/verify_password_request/verify_password_request.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/response/forget_password_response/forget_password_response.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/response/reset_password_response/reset_password_response.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/response/verify_password_response/verify_password_response.dart';
import 'package:flowers_app/Features/auth/data/models/login_models/login_request.dart';
import 'package:flowers_app/Features/auth/data/models/login_models/login_response.dart';
import 'package:flowers_app/Features/auth/data/models/signup_models/signup_request.dart';
import 'package:flowers_app/Features/auth/data/models/signup_models/signup_response.dart';
import 'package:flowers_app/Features/auth/domain/auth_repo_contract/auth_repo_contract.dart';
import 'package:flowers_app/Features/auth/domain/entities/forget_password_entity.dart';
import 'package:flowers_app/Features/auth/domain/entities/login_entity.dart';
import 'package:flowers_app/Features/auth/domain/entities/reset_password_entity.dart';
import 'package:flowers_app/Features/auth/domain/entities/signup_entity.dart';
import 'package:flowers_app/Features/auth/domain/entities/verify_password_entity.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flowers_app/core/helpers/api_execution_mixin.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRepoContract)
class AuthRepoImple with ApiExecutionMixin implements AuthRepoContract {
  final AuthRemoteDataSourceContract _remoteDataSource;
  final AuthLocalDataSourceContract _localDataSource;

  AuthRepoImple(this._remoteDataSource, this._localDataSource);

  @override
  Future<BaseResponse<SignupEntity>> signUp(SignupRequest request) async {
    return execute<SignupResponse, SignupEntity>(
      action: () async => await _remoteDataSource.signUp(request),
      mapper: (response) => response.toEntity(),
    );
  }

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
      final userId = result.data.user?.id;
      if (token != null && token.isNotEmpty) {
        await _localDataSource.saveToken(token);
        await _localDataSource.saveRememberMe(isRememberMe);
      }
      if (userId != null && userId.isNotEmpty) {
        await _localDataSource.saveUserId(userId);
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
