import 'package:flowers_app/Features/auth/data/models/forget_password/responce/forget_password_responce.dart';
import 'package:flowers_app/Features/auth/domain/entities/forget_password_entity.dart';

extension ForgetPasswordMapper on ForgetPasswordResponce {
  ForgetPasswordEntity toEntity() {
    return ForgetPasswordEntity(
      message: message ?? '',
      info: info ?? '',
    );
  }
}
