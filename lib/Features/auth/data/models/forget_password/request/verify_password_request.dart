import 'package:json_annotation/json_annotation.dart';

part 'verify_password_request.g.dart';

@JsonSerializable()
class VerifyPasswordRequest {
  @JsonKey(name: "resetCode")
  final String? resetCode;

  VerifyPasswordRequest ({
    this.resetCode,
  });

  factory VerifyPasswordRequest.fromJson(Map<String, dynamic> json) {
    return _$VerifyPasswordRequestFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$VerifyPasswordRequestToJson(this);
  }
}


