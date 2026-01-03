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

import '../../Features/products/api/api_client/products_api.dart' as _i308;
import '../../Features/products/api/products_remote_data_source_impl/products_remote_data_source_impl.dart'
    as _i639;
import '../../Features/products/data/products_data_source_contract/products_data_source_contract.dart'
    as _i166;
import '../../Features/products/data/products_repo_impl/products_repo_impl.dart'
    as _i988;
import '../../Features/products/domain/products_repo_contract/products_repo_contract.dart'
    as _i472;
import '../../Features/products/domain/use_cases/products_usecase.dart'
    as _i804;
import '../../Features/products/presentation/view_model/products_view_model.dart'
    as _i401;
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
    gh.lazySingleton<_i308.ProductsApi>(
      () => _i308.ProductsApi(gh<_i361.Dio>()),
    );
    gh.factory<_i166.ProductsRemoteDataSourceContract>(
      () => _i639.ProductsRemoteDataSourceImpl(gh<_i308.ProductsApi>()),
    );
    gh.factory<_i472.ProductsRepoContract>(
      () =>
          _i988.ProductsRepoImpl(gh<_i166.ProductsRemoteDataSourceContract>()),
    );
    gh.factory<_i804.ProductsUseCase>(
      () => _i804.ProductsUseCase(gh<_i472.ProductsRepoContract>()),
    );
    gh.factory<_i401.ProductsViewModel>(
      () => _i401.ProductsViewModel(gh<_i804.ProductsUseCase>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i505.RegisterModule {}

class _$DioModule extends _i948.DioModule {}
