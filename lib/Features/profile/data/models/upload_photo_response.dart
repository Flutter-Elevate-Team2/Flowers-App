import 'package:json_annotation/json_annotation.dart';

part 'upload_photo_response.g.dart';

@JsonSerializable()
class UploadPhotoResponse {
  final String message;

  UploadPhotoResponse({required this.message});

  factory UploadPhotoResponse.fromJson(Map<String, dynamic> json) =>
      _$UploadPhotoResponseFromJson(json);
}
