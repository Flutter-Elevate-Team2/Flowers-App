import 'package:json_annotation/json_annotation.dart';

part 'verify_password_responce.g.dart';

@JsonSerializable()
class VerifyPasswordResponce {
  String? status;

  VerifyPasswordResponce({this.status});

  factory VerifyPasswordResponce.fromJson(Map<String, dynamic> json) {
    return _$VerifyPasswordResponceFromJson(json);
  }

  Map<String, dynamic> toJson() => _$VerifyPasswordResponceToJson(this);
}
