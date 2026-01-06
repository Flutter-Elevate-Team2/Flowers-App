import 'package:json_annotation/json_annotation.dart';

part 'reset_password_response.g.dart';

@JsonSerializable()
class ResetPasswordResponse {
  String? message;
  String? token;

  ResetPasswordResponse({this.message, this.token});

  factory ResetPasswordResponse.fromJson(Map<String, dynamic> json) {
    return _$ResetPasswordResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ResetPasswordResponseToJson(this);
}
