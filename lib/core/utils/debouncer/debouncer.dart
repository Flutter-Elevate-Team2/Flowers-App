import 'package:flutter/foundation.dart';

abstract class Debouncer {
  void run(VoidCallback action);
  void dispose();
}
