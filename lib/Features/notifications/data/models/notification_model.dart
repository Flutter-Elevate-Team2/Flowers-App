import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notification_model.g.dart';

class TimestampConverter implements JsonConverter<DateTime, dynamic> {
  const TimestampConverter();

  @override
  DateTime fromJson(dynamic timestamp) {
    if (timestamp is Timestamp) {
      return timestamp.toDate();
    } else if (timestamp is String) {
      return DateTime.parse(timestamp);
    }
    return DateTime.now();
  }

  @override
  dynamic toJson(DateTime date) => Timestamp.fromDate(date);
}

@JsonSerializable()
class NotificationModel {
  final String id;
  final String body;
  final bool isRead;

  final String title;
  final String? orderId;
  final String? status;
  final String? receiverId;

  @TimestampConverter()
  final DateTime sentAt;

  NotificationModel({
    required this.id,
    required this.body,
    required this.title,
    this.isRead = false,
    this.orderId,
    this.status,
    this.receiverId,
    required this.sentAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('metadata') && json['metadata'] != null) {
      final metadata = json['metadata'] as Map<String, dynamic>;
      json.addAll(metadata);
    }
    return _$NotificationModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);
}
