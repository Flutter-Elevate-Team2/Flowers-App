import 'package:flowers_app/core/l10n/view_model/language_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flowers_app/core/di/di.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late SharedPreferences prefs;

  setUp(() async {
    TestWidgetsFlutterBinding.ensureInitialized();

    SharedPreferences.setMockInitialValues({});

    prefs = await SharedPreferences.getInstance();

    getIt.reset();
    getIt.registerSingleton<SharedPreferences>(prefs);
  });

  tearDown(() {
    getIt.reset();
  });

  group('LanguageCubit', () {
    test('initial state is Locale(en) when no saved language', () {
      final cubit = LanguageCubit();

      expect(cubit.state, const Locale('en'));
    });

  });
}
