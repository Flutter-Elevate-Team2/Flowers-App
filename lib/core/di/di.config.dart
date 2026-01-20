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
import '../../Features/commerce/api/api_client/commerce_api.dart' as _i516;
import '../../Features/commerce/api/commerce_data_source_impl/commerce_remote_data_source_impl.dart'
    as _i532;
import '../../Features/commerce/data/commerce_data_source_contract/commerce_remote_data_source_contract.dart'
    as _i10;
import '../../Features/commerce/data/repos/commerce_repo_impl.dart' as _i48;
import '../../Features/commerce/domain/repos/commerce_repo_contract.dart'
    as _i596;
import '../../Features/commerce/domain/use_cases/get_home_sections_use_case.dart'
    as _i783;
import '../../Features/commerce/domain/use_cases/products_usecase.dart'
    as _i183;
import '../../Features/commerce/presentation/home/view_model/home_view_model.dart'
    as _i945;
import '../../Features/commerce/presentation/products/view_model/products_view_model.dart'
    as _i378;
import '../../Features/profile/api/api_client/profile_api_client.dart' as _i255;
import '../../Features/profile/api/data_sources/remote_data_source_impe/profile_remote_data_source_impe.dart'
    as _i408;
import '../../Features/profile/api/profile_local_data_source_imple/profile_local_data_source_impl.dart'
    as _i250;
import '../../Features/profile/data/data_sources/local_data_source_contract/profile_local_data_source_contract.dart'
    as _i709;
import '../../Features/profile/data/data_sources/remote_data_source_contract/profile_remote_data_source_contract.dart'
    as _i897;
import '../../Features/profile/data/repo/profile_repo_imple.dart' as _i327;
import '../../Features/profile/domain/repo/profile_repo_contract.dart' as _i671;
import '../../Features/profile/domain/use_cases/change_password_use_case.dart'
    as _i994;
import '../../Features/profile/domain/use_cases/edit_profile_use_case.dart'
    as _i512;
import '../../Features/profile/domain/use_cases/logout_use_case.dart' as _i40;
import '../../Features/profile/domain/use_cases/profile_use_case.dart' as _i951;
import '../../Features/profile/domain/use_cases/upload_photo_use_case.dart'
    as _i417;
import '../../Features/profile/presentation/view_model/profile_view_model.dart'
    as _i149;
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
    gh.factory<_i709.ProfileLocalDataSourceContract>(
      () => _i250.ProfileLocalDataSourceImpl(gh<_i460.SharedPreferences>()),
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
    gh.lazySingleton<_i516.CommerceApi>(
      () => _i516.CommerceApi(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i255.ProfileApi>(() => _i255.ProfileApi(gh<_i361.Dio>()));
    gh.factory<_i897.ProfileRemoteDataSourceContract>(
      () => _i408.ProfileRemoteDataSourceImpl(gh<_i255.ProfileApi>()),
    );
    gh.factory<_i978.AuthRemoteDataSourceContract>(
      () => _i813.AuthRemoteDataSourceImple(gh<_i888.AuthApi>()),
    );
    gh.factory<_i10.CommerceRemoteDataSourceContract>(
      () => _i532.CommerceRemoteDataSourceImpl(gh<_i516.CommerceApi>()),
    );
    gh.factory<_i596.CommerceRepoContract>(
      () => _i48.CommerceRepoImpl(gh<_i10.CommerceRemoteDataSourceContract>()),
    );
    gh.factory<_i30.AuthRepoContract>(
      () => _i573.AuthRepoImple(
        gh<_i978.AuthRemoteDataSourceContract>(),
        gh<_i164.AuthLocalDataSourceContract>(),
      ),
    );
    gh.factory<_i671.ProfileRepoContract>(
      () => _i327.ProfileRepoImpl(gh<_i897.ProfileRemoteDataSourceContract>()),
    );
    gh.factory<_i40.LogoutUseCase>(
      () => _i40.LogoutUseCase(
        gh<_i671.ProfileRepoContract>(),
        gh<_i460.SharedPreferences>(),
        gh<_i306.SessionController>(),
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
    gh.factory<_i762.ForgetPasswordUsecase>(
      () => _i762.ForgetPasswordUsecase(gh<_i30.AuthRepoContract>()),
    );
    gh.factory<_i785.ResetPasswordUsecase>(
      () => _i785.ResetPasswordUsecase(gh<_i30.AuthRepoContract>()),
    );
    gh.factory<_i13.VerifyPasswordUsecase>(
      () => _i13.VerifyPasswordUsecase(gh<_i30.AuthRepoContract>()),
    );
    gh.factory<_i783.GetHomeSectionsUseCase>(
      () => _i783.GetHomeSectionsUseCase(gh<_i596.CommerceRepoContract>()),
    );
    gh.factory<_i183.ProductsUseCase>(
      () => _i183.ProductsUseCase(gh<_i596.CommerceRepoContract>()),
    );
    gh.factory<_i378.ProductsViewModel>(
      () => _i378.ProductsViewModel(
        gh<_i183.ProductsUseCase>(),
        gh<_i783.GetHomeSectionsUseCase>(),
      ),
    );
    gh.factory<_i994.ChangePasswordUseCase>(
      () => _i994.ChangePasswordUseCase(gh<_i671.ProfileRepoContract>()),
    );
    gh.factory<_i512.EditProfileUseCase>(
      () => _i512.EditProfileUseCase(gh<_i671.ProfileRepoContract>()),
    );
    gh.factory<_i951.GetProfileUseCase>(
      () => _i951.GetProfileUseCase(gh<_i671.ProfileRepoContract>()),
    );
    gh.factory<_i417.UploadPhotoUseCase>(
      () => _i417.UploadPhotoUseCase(gh<_i671.ProfileRepoContract>()),
    );
    gh.factory<_i710.LoginViewModel>(
      () => _i710.LoginViewModel(gh<_i512.LoginUseCase>()),
    );
    gh.factory<_i945.HomeViewModel>(
      () => _i945.HomeViewModel(gh<_i783.GetHomeSectionsUseCase>()),
    );
    gh.factory<_i427.ForgetPasswordCubit>(
      () => _i427.ForgetPasswordCubit(
        gh<_i762.ForgetPasswordUsecase>(),
        gh<_i13.VerifyPasswordUsecase>(),
        gh<_i785.ResetPasswordUsecase>(),
      ),
    );
    gh.factory<_i149.ProfileViewModel>(
      () => _i149.ProfileViewModel(
        gh<_i951.GetProfileUseCase>(),
        gh<_i512.EditProfileUseCase>(),
        gh<_i994.ChangePasswordUseCase>(),
        gh<_i417.UploadPhotoUseCase>(),
        gh<_i709.ProfileLocalDataSourceContract>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i505.RegisterModule {}

class _$DioModule extends _i948.DioModule {}
