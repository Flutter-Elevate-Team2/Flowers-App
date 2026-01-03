import 'package:flowers_app/Features/auth/data/models/forget_password/responce/verify_password_responce.dart';
import 'package:flowers_app/Features/auth/domain/entities/verify_password_entity.dart';

extension VerifyPasswordMapper on VerifyPasswordResponce {
  VerifyPasswordEntity toEntity() {
    return VerifyPasswordEntity(
      status: status ?? '',
    );
  }
}
