import 'package:json_annotation/json_annotation.dart';

part 'forget_password_request.g.dart';

@JsonSerializable()
class ForgetPasswordRequest {
	String? email;

	ForgetPasswordRequest({this.email});

	factory ForgetPasswordRequest.fromJson(Map<String, dynamic> json) {
		return _$ForgetPasswordRequestFromJson(json);
	}

	Map<String, dynamic> toJson() => _$ForgetPasswordRequestToJson(this);
}
