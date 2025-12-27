import 'package:json_annotation/json_annotation.dart';

part 'Reset_Password_Request.g.dart';

@JsonSerializable()
class ResetPasswordRequest {
  @JsonKey(name: "email")
  final String? email;
  @JsonKey(name: "newPassword")
  final String? newPassword;

  ResetPasswordRequest ({
    this.email,
    this.newPassword,
  });

  factory ResetPasswordRequest.fromJson(Map<String, dynamic> json) {
    return _$ResetPasswordRequestFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ResetPasswordRequestToJson(this);
  }
}


