import 'package:json_annotation/json_annotation.dart';

part 'reset_password_request.g.dart';

@JsonSerializable()
class ResetPasswordRequest {
  String? email;
  String? newPassword;

  ResetPasswordRequest({this.email, this.newPassword});

  factory ResetPasswordRequest.fromJson(Map<String, dynamic> json) {
    return _$ResetPasswordRequestFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ResetPasswordRequestToJson(this);
}
