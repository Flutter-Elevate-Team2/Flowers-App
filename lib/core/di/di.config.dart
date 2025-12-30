// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart' as _i695;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:pretty_dio_logger/pretty_dio_logger.dart' as _i528;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../Features/home/api/api_client/home_api.dart' as _i551;
import '../../Features/home/api/data_source_imple/home_remote_data_source.dart'
    as _i978;
import '../../Features/home/data/data_source_contract/home_remote_data_source_contract.dart'
    as _i968;
import '../../Features/home/data/repo/home_repo_imple.dart' as _i779;
import '../../Features/home/domain/repo/home_repo_contract.dart' as _i502;
import '../../Features/home/domain/use_cases/get_home_sections_use_case.dart'
    as _i301;
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
    gh.singleton<_i695.CacheStore>(() => dioModule.cacheStore);
    gh.singleton<_i695.CacheOptions>(() => dioModule.cacheOptions);
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
        gh<_i695.CacheOptions>(),
      ),
    );
    gh.lazySingleton<_i551.HomeApi>(() => _i551.HomeApi(gh<_i361.Dio>()));
    gh.factory<_i968.HomeRemoteDataSourceContract>(
      () => _i978.HomeRemoteDataSource(gh<_i551.HomeApi>()),
    );
    gh.factory<_i502.HomeRepoContract>(
      () => _i779.HomeRepoImple(gh<_i968.HomeRemoteDataSourceContract>()),
    );
    gh.factory<_i301.GetHomeSectionsUseCase>(
      () => _i301.GetHomeSectionsUseCase(gh<_i502.HomeRepoContract>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i505.RegisterModule {}

class _$DioModule extends _i948.DioModule {}
