import 'package:json_annotation/json_annotation.dart';

import 'metadata.dart';

part 'notification_response.g.dart';

@JsonSerializable()
class NotificationResponse {
  String? message;
  Metadata? metadata;
  List<dynamic>? notifications;

  NotificationResponse({this.message, this.metadata, this.notifications});

  factory NotificationResponse.fromJson(Map<String, dynamic> json) {
    return _$NotificationResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$NotificationResponseToJson(this);
}
