import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateOrderState {
  Future<void> saveStatusUpdate(String orderId, String status,
      DateTime updatedAt) async {
    final prefs = await SharedPreferences.getInstance();
    final key = "order_status_history_$orderId";

    final existing = prefs.getString(key);
    List<StatusRecord> records = [];

    if (existing != null) {
      final list = jsonDecode(existing) as List;
      records = list.map((e) => StatusRecord.fromJson(e)).toList();
    }

    // أضف السجل الجديد
    records.add(StatusRecord(status: status, time: updatedAt));

    await prefs.setString(
        key, jsonEncode(records.map((e) => e.toJson()).toList()));
  }

  Future<List<StatusRecord>> getStatusHistory(String orderId) async {
    final prefs = await SharedPreferences.getInstance();
    final key = "order_status_history_$orderId";

    final existing = prefs.getString(key);
    if (existing != null) {
      final list = jsonDecode(existing) as List;
      return list.map((e) => StatusRecord.fromJson(e)).toList();
    }
    return [];
  }
}

class StatusRecord {
  final String status;
  final DateTime time;

  StatusRecord({required this.status, required this.time});

  Map<String, dynamic> toJson() => {
    'status': status,
    'time': time.toIso8601String(),
  };

  factory StatusRecord.fromJson(Map<String, dynamic> json) => StatusRecord(
    status: json['status'],
    time: DateTime.parse(json['time']),
  );
}