import 'package:json_annotation/json_annotation.dart';

part 'reset_password_responce.g.dart';

@JsonSerializable()
class ResetPasswordResponce {
  String? message;
  String? token;

  ResetPasswordResponce({this.message, this.token});

  factory ResetPasswordResponce.fromJson(Map<String, dynamic> json) {
    return _$ResetPasswordResponceFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ResetPasswordResponceToJson(this);
}
