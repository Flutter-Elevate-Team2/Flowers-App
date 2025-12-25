// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:pretty_dio_logger/pretty_dio_logger.dart' as _i528;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../Features/auth/api/api_client/auth_api.dart' as _i888;
import '../../Features/auth/api/auth_data_source_imple/auth_remote_data_source_imple.dart'
    as _i813;
import '../../Features/auth/data/auth_data_source_contract/auth_remote_data_source_contract.dart'
    as _i978;
import '../../Features/auth/data/auth_repo_imple/auth_repo_imple.dart' as _i573;
import '../../Features/auth/domain/auth_repo_contract/auth_repo_contract.dart'
    as _i30;
import '../../Features/auth/domain/use_cases/forget_password_usecase.dart'
    as _i762;
import '../../Features/auth/domain/use_cases/reset_password_usecase.dart'
    as _i785;
import '../../Features/auth/domain/use_cases/verify_password_usecase.dart'
    as _i13;
import '../../Features/auth/presentation/forget_password/view_model/forget_password_cubit.dart'
    as _i427;
import '../auth_interceptors/auth_interceptors.dart' as _i453;
import '../controller/session_controller.dart' as _i306;
import '../modules/dio_module.dart' as _i948;
import '../modules/register_module.dart' as _i505;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    final dioModule = _$DioModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => registerModule.prefs,
      preResolve: true,
    );
    gh.singleton<_i306.SessionController>(
      () => _i306.SessionController(),
      dispose: (i) => i.dispose(),
    );
    gh.singleton<_i528.PrettyDioLogger>(() => dioModule.prettyDioLogger);
    gh.factory<_i453.AuthInterceptor>(
      () => _i453.AuthInterceptor(
        gh<_i460.SharedPreferences>(),
        gh<_i306.SessionController>(),
      ),
    );
    gh.singleton<_i361.Dio>(
      () => dioModule.dio(
        gh<_i453.AuthInterceptor>(),
        gh<_i528.PrettyDioLogger>(),
      ),
    );
    gh.lazySingleton<_i888.AuthApi>(() => _i888.AuthApi(gh<_i361.Dio>()));
    gh.factory<_i978.AuthRemoteDataSourceContract>(
      () => _i813.AuthRemoteDataSourceImple(gh<_i888.AuthApi>()),
    );
    gh.factory<_i30.AuthRepoContract>(
      () => _i573.AuthRepoImple(gh<_i978.AuthRemoteDataSourceContract>()),
    );
    gh.factory<_i762.ForgetPasswordUsecase>(
      () => _i762.ForgetPasswordUsecase(gh<_i30.AuthRepoContract>()),
    );
    gh.factory<_i785.ResetPasswordUsecase>(
      () => _i785.ResetPasswordUsecase(gh<_i30.AuthRepoContract>()),
    );
    gh.factory<_i13.VerifyPasswordUsecase>(
      () => _i13.VerifyPasswordUsecase(gh<_i30.AuthRepoContract>()),
    );
    gh.factory<_i427.ForgetPasswordCubit>(
      () => _i427.ForgetPasswordCubit(
        gh<_i762.ForgetPasswordUsecase>(),
        gh<_i13.VerifyPasswordUsecase>(),
        gh<_i785.ResetPasswordUsecase>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i505.RegisterModule {}

class _$DioModule extends _i948.DioModule {}
