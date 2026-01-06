import 'package:flowers_app/Features/auth/data/models/forget_password/response/forget_password_response/forget_password_response.dart';
import 'package:flowers_app/Features/auth/domain/entities/forget_password_entity.dart';

extension ForgetPasswordMapper on ForgetPasswordResponse {
  ForgetPasswordEntity toEntity() {
    return ForgetPasswordEntity(message: message ?? '', info: info ?? '');
  }
}
