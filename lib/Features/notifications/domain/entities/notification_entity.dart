import 'package:equatable/equatable.dart';

class NotificationEntity extends Equatable {
  final String id;
  final String title;
  final String body;
  final bool isRead;
  final String? orderId;
  final String? status;
  final DateTime sentAt;

  const NotificationEntity({
    required this.id,
    required this.title,
    required this.body,
    required this.isRead,
    this.orderId,
    this.status,
    required this.sentAt,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        body,
        isRead,
        orderId,
        status,
        sentAt,
      ];
}