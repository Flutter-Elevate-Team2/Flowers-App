import 'package:flowers_app/core/utils/debouncer/debouncer.dart';
import 'package:flutter/foundation.dart';

class ImmediateDebouncer implements Debouncer {
  @override
  void run(VoidCallback action) {
    action();
  }

  @override
  void dispose() {}
}
