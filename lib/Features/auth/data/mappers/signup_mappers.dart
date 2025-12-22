import 'package:flowers_app/Features/auth/data/models/signup_models/signup_response.dart';
import 'package:flowers_app/Features/auth/data/models/signup_models/user_dto.dart';

import '../../domain/entities/signup_entity.dart';

extension SignupResponseMapper on SignupResponse {
  SignupEntity toEntity() {
    return SignupEntity(
      token: token,
      user: user?.toEntity(),
    );
  }
}

extension UserDtoMapper on UserDto {
  SignupUserEntity toEntity() {
    return SignupUserEntity(
      firstName: firstName ?? '',
      lastName: lastName ?? '',
      email: email ?? '',
      phone: phone ?? '',
      gender: gender ?? '',
    );
  }
}
