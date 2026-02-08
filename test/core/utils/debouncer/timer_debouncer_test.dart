import 'package:fake_async/fake_async.dart';
import 'package:flowers_app/core/utils/debouncer/timer_debouncer.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late TimerDebouncer debouncer;

  setUp(() {
    debouncer = TimerDebouncer();
  });

  tearDown(() {
    debouncer.dispose();
  });

  group('TimerDebouncer', () {
    test('delays execution of action', () {
      fakeAsync((async) {
        bool called = false;
        debouncer.run(() {
          called = true;
        });

        // Should not be called immediately
        expect(called, isFalse);

        // Advance time partially
        async.elapse(const Duration(milliseconds: 100));
        expect(called, isFalse);

        // Advance past delay (300ms default)
        async.elapse(const Duration(milliseconds: 201));
        expect(called, isTrue);
      });
    });

    test('cancels previous action if called repeatedly', () {
      fakeAsync((async) {
        int callCount = 0;

        // Call 1
        debouncer.run(() {
          callCount++;
        });

        async.elapse(const Duration(milliseconds: 100));

        // Call 2 (should reset timer)
        debouncer.run(() {
          callCount++;
        });

        async.elapse(const Duration(milliseconds: 200));
        // Total 300ms from start, but only 200ms from 2nd call.
        // Logic: 100ms passed. 2nd call happens. Timer resets to 300ms.
        // We advanced another 200ms. Total time 300ms, but timer needs 100ms more.
        expect(callCount, 0);

        async.elapse(const Duration(milliseconds: 101));
        expect(callCount, 1); // Only the second one should fire
      });
    });

    test('dispose cancels timer', () {
      fakeAsync((async) {
        bool called = false;
        debouncer.run(() {
          called = true;
        });

        debouncer.dispose();
        async.elapse(const Duration(milliseconds: 400));
        expect(called, isFalse);
      });
    });
  });
}
