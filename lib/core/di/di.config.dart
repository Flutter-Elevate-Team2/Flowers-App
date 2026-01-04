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

import '../../Features/auth/api/api_client/auth_api.dart' as _i888;
import '../../Features/auth/api/auth_data_source_imple/auth_remote_data_source_imple.dart'
    as _i813;
import '../../Features/auth/api/auth_local_data_source_imple/auth_local_data_source_imple.dart'
    as _i1051;
import '../../Features/auth/data/auth_data_source_contract/auth_local_data_source_contract.dart'
    as _i164;
import '../../Features/auth/data/auth_data_source_contract/auth_remote_data_source_contract.dart'
    as _i978;
import '../../Features/auth/data/auth_repo_imple/auth_repo_imple.dart' as _i573;
import '../../Features/auth/domain/auth_repo_contract/auth_repo_contract.dart'
    as _i30;
import '../../Features/auth/domain/use_cases/check_auth_usecase.dart' as _i409;
import '../../Features/auth/domain/use_cases/forget_password_usecase.dart'
    as _i762;
import '../../Features/auth/domain/use_cases/login_usecase.dart' as _i512;
import '../../Features/auth/domain/use_cases/reset_password_usecase.dart'
    as _i785;
import '../../Features/auth/domain/use_cases/signup_usecase.dart' as _i179;
import '../../Features/auth/domain/use_cases/verify_password_usecase.dart'
    as _i13;
import '../../Features/auth/presentation/forget_password/view_model/forget_password_cubit.dart'
    as _i427;
import '../../Features/auth/presentation/sign_in/view_model/login_view_model.dart'
    as _i710;
import '../../Features/auth/presentation/sign_up/view_model/sign_up_view_model.dart'
    as _i318;
import '../../Features/commerce/home/api/api_client/home_api.dart' as _i657;
import '../../Features/commerce/home/api/data_source_imple/home_remote_data_source.dart'
    as _i218;
import '../../Features/commerce/home/data/data_source_contract/home_remote_data_source_contract.dart'
    as _i754;
import '../../Features/commerce/home/data/repo/home_repo_imple.dart' as _i451;
import '../../Features/commerce/home/domain/repo/home_repo_contract.dart'
    as _i751;
import '../../Features/commerce/home/domain/use_cases/get_home_sections_use_case.dart'
    as _i579;
import '../../Features/commerce/home/presentation/view_model/home_view_model.dart'
    as _i73;
import '../../Features/commerce/products/api/api_client/products_api.dart'
    as _i988;
import '../../Features/commerce/products/api/products_remote_data_source_impl/products_remote_data_source_impl.dart'
    as _i565;
import '../../Features/commerce/products/data/products_data_source_contract/products_data_source_contract.dart'
    as _i557;
import '../../Features/commerce/products/data/products_repo_impl/products_repo_impl.dart'
    as _i660;
import '../../Features/commerce/products/domain/products_repo_contract/products_repo_contract.dart'
    as _i549;
import '../../Features/commerce/products/domain/use_cases/products_usecase.dart'
    as _i226;
import '../../Features/commerce/products/presentation/view_model/products_view_model.dart'
    as _i8;
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
    gh.singleton<_i695.MemCacheStore>(() => dioModule.memCacheStore);
    gh.factory<_i453.AuthInterceptor>(
      () => _i453.AuthInterceptor(
        gh<_i460.SharedPreferences>(),
        gh<_i306.SessionController>(),
      ),
    );
    gh.factory<_i164.AuthLocalDataSourceContract>(
      () => _i1051.AuthLocalDataSourceImple(gh<_i460.SharedPreferences>()),
    );
    gh.singleton<_i695.CacheOptions>(
      () => dioModule.cacheOptions(gh<_i695.MemCacheStore>()),
    );
    gh.singleton<_i361.Dio>(
      () => dioModule.dio(
        gh<_i453.AuthInterceptor>(),
        gh<_i528.PrettyDioLogger>(),
        gh<_i695.CacheOptions>(),
      ),
    );
    gh.lazySingleton<_i888.AuthApi>(() => _i888.AuthApi(gh<_i361.Dio>()));
    gh.lazySingleton<_i657.HomeApi>(() => _i657.HomeApi(gh<_i361.Dio>()));
    gh.lazySingleton<_i988.ProductsApi>(
      () => _i988.ProductsApi(gh<_i361.Dio>()),
    );
    gh.factory<_i978.AuthRemoteDataSourceContract>(
      () => _i813.AuthRemoteDataSourceImple(gh<_i888.AuthApi>()),
    );
    gh.factory<_i557.ProductsRemoteDataSourceContract>(
      () => _i565.ProductsRemoteDataSourceImpl(gh<_i988.ProductsApi>()),
    );
    gh.factory<_i754.HomeRemoteDataSourceContract>(
      () => _i218.HomeRemoteDataSource(gh<_i657.HomeApi>()),
    );
    gh.factory<_i30.AuthRepoContract>(
      () => _i573.AuthRepoImple(
        gh<_i978.AuthRemoteDataSourceContract>(),
        gh<_i164.AuthLocalDataSourceContract>(),
      ),
    );
    gh.factory<_i409.CheckAuthUseCase>(
      () => _i409.CheckAuthUseCase(gh<_i30.AuthRepoContract>()),
    );
    gh.factory<_i512.LoginUseCase>(
      () => _i512.LoginUseCase(gh<_i30.AuthRepoContract>()),
    );
    gh.factory<_i179.SignupUseCase>(
      () => _i179.SignupUseCase(gh<_i30.AuthRepoContract>()),
    );
    gh.factory<_i318.SignUpViewModel>(
      () => _i318.SignUpViewModel(gh<_i179.SignupUseCase>()),
    );
    gh.factory<_i751.HomeRepoContract>(
      () => _i451.HomeRepoImple(gh<_i754.HomeRemoteDataSourceContract>()),
    );
    gh.factory<_i549.ProductsRepoContract>(
      () =>
          _i660.ProductsRepoImpl(gh<_i557.ProductsRemoteDataSourceContract>()),
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
    gh.factory<_i579.GetHomeSectionsUseCase>(
      () => _i579.GetHomeSectionsUseCase(gh<_i751.HomeRepoContract>()),
    );
    gh.factory<_i710.LoginViewModel>(
      () => _i710.LoginViewModel(gh<_i512.LoginUseCase>()),
    );
    gh.factory<_i427.ForgetPasswordCubit>(
      () => _i427.ForgetPasswordCubit(
        gh<_i762.ForgetPasswordUsecase>(),
        gh<_i13.VerifyPasswordUsecase>(),
        gh<_i785.ResetPasswordUsecase>(),
      ),
    );
    gh.factory<_i226.ProductsUseCase>(
      () => _i226.ProductsUseCase(gh<_i549.ProductsRepoContract>()),
    );
    gh.factory<_i8.ProductsViewModel>(
      () => _i8.ProductsViewModel(
        gh<_i226.ProductsUseCase>(),
        gh<_i579.GetHomeSectionsUseCase>(),
      ),
    );
    gh.factory<_i73.HomeViewModel>(
      () => _i73.HomeViewModel(gh<_i579.GetHomeSectionsUseCase>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i505.RegisterModule {}

class _$DioModule extends _i948.DioModule {}
