import 'package:json_annotation/json_annotation.dart';

part 'change_password_request.g.dart';

@JsonSerializable()
class ChangePasswordRequest {
  final String password;
  final String newPassword;

  ChangePasswordRequest({
    required this.password,
    required this.newPassword,
  });

  Map<String, dynamic> toJson() => _$ChangePasswordRequestToJson(this);
}
