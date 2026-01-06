import 'package:flowers_app/Features/auth/data/models/forget_password/response/verify_password_response/verify_password_response.dart';
import 'package:flowers_app/Features/auth/domain/entities/verify_password_entity.dart';

extension VerifyPasswordMapper on VerifyPasswordResponse {
  VerifyPasswordEntity toEntity() {
    return VerifyPasswordEntity(status: status ?? '');
  }
}
