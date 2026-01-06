import 'package:json_annotation/json_annotation.dart';

part 'change_password_response.g.dart';

@JsonSerializable()
class ChangePasswordResponse {
  final String message;
  final String? token;

  ChangePasswordResponse({required this.message, this.token});

  factory ChangePasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ChangePasswordResponseFromJson(json);
}
