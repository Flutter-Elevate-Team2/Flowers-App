import 'package:json_annotation/json_annotation.dart';

part 'verify_password_response.g.dart';

@JsonSerializable()
class VerifyPasswordResponse {
	String? status;

	VerifyPasswordResponse({this.status});

	factory VerifyPasswordResponse.fromJson(Map<String, dynamic> json) {
		return _$VerifyPasswordResponseFromJson(json);
	}

	Map<String, dynamic> toJson() => _$VerifyPasswordResponseToJson(this);
}
