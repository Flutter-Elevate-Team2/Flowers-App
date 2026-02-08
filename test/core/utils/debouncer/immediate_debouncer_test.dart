import 'package:flowers_app/core/utils/debouncer/immediate_debouncer.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('ImmediateDebouncer runs action immediately', () {
    bool called = false;
    final debouncer = ImmediateDebouncer();

    debouncer.run(() {
      called = true;
    });

    expect(called, isTrue);
  });
}
