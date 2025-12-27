import 'package:json_annotation/json_annotation.dart';

part 'Verify_Password_Responce.g.dart';

@JsonSerializable()
class VerifyPasswordResponce {
  @JsonKey(name: "status")
  final String? status;

  VerifyPasswordResponce ({
    this.status,
  });

  factory VerifyPasswordResponce.fromJson(Map<String, dynamic> json) {
    return _$VerifyPasswordResponceFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$VerifyPasswordResponceToJson(this);
  }
}


