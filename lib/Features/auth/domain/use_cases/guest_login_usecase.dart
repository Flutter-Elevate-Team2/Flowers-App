import 'package:flowers_app/Features/auth/data/auth_data_source_contract/auth_local_data_source_contract.dart';
import 'package:flowers_app/Features/auth/domain/entities/login_entity.dart';
import 'package:injectable/injectable.dart';

@injectable
class GuestLoginUseCase {
  final AuthLocalDataSourceContract _localDataSource;

  GuestLoginUseCase(this._localDataSource);

  Future<LoginEntity> call() async {
    await _localDataSource.clearUserData();
    return LoginEntity(token: null, message: "Guest", user: null);
  }
}
