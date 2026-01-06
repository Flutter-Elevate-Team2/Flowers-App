import 'package:json_annotation/json_annotation.dart';
import 'user_dto.dart';

part 'signup_response.g.dart';

@JsonSerializable()
class SignupResponse {
  @JsonKey(name: "message")
  String? message;

  @JsonKey(name: "user")
  UserDto? user;

  @JsonKey(name: "token")
  String? token;

  SignupResponse({this.message, this.user, this.token});

  factory SignupResponse.fromJson(Map<String, dynamic> json) =>
      _$SignupResponseFromJson(json);
}
