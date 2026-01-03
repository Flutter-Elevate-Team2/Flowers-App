import 'package:json_annotation/json_annotation.dart';

part 'signup_request.g.dart';

@JsonSerializable()
class SignupRequest {
  @JsonKey(name: "firstName")
  final String firstName;

  @JsonKey(name: "lastName")
  final String lastName;

  @JsonKey(name: "email")
  final String email;

  @JsonKey(name: "password")
  final String password;

  @JsonKey(name: "rePassword")
  final String rePassword;

  @JsonKey(name: "phone")
  final String phone;

  @JsonKey(name: "gender")
  final String gender;

  SignupRequest({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.rePassword,
    required this.phone,
    required this.gender,
  });

  Map<String, dynamic> toJson() => _$SignupRequestToJson(this);
}
