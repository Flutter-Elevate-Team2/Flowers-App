import 'package:flowers_app/Features/auth/data/models/login_models/login_response.dart';
import 'package:flowers_app/Features/auth/domain/entities/login_entity.dart';

extension LoginResponseMapper on LoginResponse {
  LoginEntity toEntity() {
    return LoginEntity(
      message: message,
      token: token,
      user: user?.toEntity(),
    );
  }
}

extension UserMapper on User {
  LoginUserEntity toEntity() {
    return LoginUserEntity(
      id: Id ?? " ",
      firstName: firstName ?? " ",
      lastName: lastName ?? " ",
      email: email ?? " ",
      gender: gender ?? " ",
      phone: phone ?? " ",
      photo: photo ?? " ",
      role: role ?? " ",
      createdAt: createdAt ?? " ",
    );
  }
}
