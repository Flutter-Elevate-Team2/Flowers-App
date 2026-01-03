import 'package:json_annotation/json_annotation.dart';

part 'forget_password_responce.g.dart';

@JsonSerializable()
class ForgetPasswordResponce {
  String? message;
  String? info;

  ForgetPasswordResponce({this.message, this.info});

  factory ForgetPasswordResponce.fromJson(Map<String, dynamic> json) {
    return _$ForgetPasswordResponceFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ForgetPasswordResponceToJson(this);
}
