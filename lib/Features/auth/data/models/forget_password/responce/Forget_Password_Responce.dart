import 'package:json_annotation/json_annotation.dart';

part 'Forget_Password_Responce.g.dart';

@JsonSerializable()
class ForgetPasswordResponce {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "info")
  final String? info;

  ForgetPasswordResponce ({
    this.message,
    this.info,
  });

  factory ForgetPasswordResponce.fromJson(Map<String, dynamic> json) {
    return _$ForgetPasswordResponceFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ForgetPasswordResponceToJson(this);
  }
}


