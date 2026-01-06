import 'package:json_annotation/json_annotation.dart';

import 'user_model.dart';

part 'profile_dto.g.dart';

@JsonSerializable()
class ProfileDto {
  String? message;
  UserModel? user;

  ProfileDto({this.message, this.user});

  factory ProfileDto.fromJson(Map<String, dynamic> json) {
    return _$ProfileDtoFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ProfileDtoToJson(this);
}
