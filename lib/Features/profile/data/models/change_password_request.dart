import 'package:json_annotation/json_annotation.dart';

part 'change_password_request.g.dart';

@JsonSerializable()
class ChangePasswordRequest {
  final String password;
  final String newPassword;

  const ChangePasswordRequest({
    required this.password,
    required this.newPassword,
  });

  Map<String, dynamic> toJson() => _$ChangePasswordRequestToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChangePasswordRequest &&
          runtimeType == other.runtimeType &&
          password == other.password &&
          newPassword == other.newPassword;

  @override
  int get hashCode => password.hashCode ^ newPassword.hashCode;
}
