import 'package:json_annotation/json_annotation.dart';

part 'Reset_Password_Responce.g.dart';

@JsonSerializable()
class ResetPasswordResponce {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "token")
  final String? token;

  ResetPasswordResponce ({
    this.message,
    this.token,
  });

  factory ResetPasswordResponce.fromJson(Map<String, dynamic> json) {
    return _$ResetPasswordResponceFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ResetPasswordResponceToJson(this);
  }
}


