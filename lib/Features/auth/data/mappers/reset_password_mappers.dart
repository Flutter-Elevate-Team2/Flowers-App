import 'package:flowers_app/Features/auth/data/models/forget_password/response/reset_password_response/reset_password_response.dart';
import 'package:flowers_app/Features/auth/domain/entities/reset_password_entity.dart';

extension ResetPasswordMapper on ResetPasswordResponse {
  ResetPasswordEntity toEntity() {
    return ResetPasswordEntity(
      message: message ?? '',
      token: token ?? '',
    );
  }
}
