import 'dart:async';
import 'package:flowers_app/core/utils/debouncer/debouncer.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: Debouncer)
class TimerDebouncer implements Debouncer {
  final Duration delay;
  Timer? _timer;

  TimerDebouncer() : delay = const Duration(milliseconds: 300);

  @override
  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(delay, action);
  }

  @override
  void dispose() {
    _timer?.cancel();
  }
}
