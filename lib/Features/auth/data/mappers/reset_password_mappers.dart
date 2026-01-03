import 'package:flowers_app/Features/auth/data/models/forget_password/responce/reset_password_responce.dart';
import 'package:flowers_app/Features/auth/domain/entities/reset_password_entity.dart';

extension ResetPasswordMapper on ResetPasswordResponce {
  ResetPasswordEntity toEntity() {
    return ResetPasswordEntity(
      message: message ?? '',
      token: token ?? '',
    );
  }
}
