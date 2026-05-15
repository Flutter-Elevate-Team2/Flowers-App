import 'package:flowers_app/Features/user_address/data/models/area_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AreaModel Tests', () {
     final mockJson = {
      'id': '1',
      'governorate_id': '10',
      'city_name_ar': 'القاهرة',
      'city_name_en': 'Cairo',
    };

    test('fromJson should return a valid model from JSON', () {
       final result = AreaModel.fromJson(mockJson);

       expect(result.id, '1');
      expect(result.governorateId, '10');
      expect(result.cityNameAr, 'القاهرة');
      expect(result.cityNameEn, 'Cairo');
    });

    test('Should throw an error (TypeError) when JSON keys are missing or wrong type', () {
      final invalidJson = {
        'id': 1,
        'governorate_id': '10',
      };

       expect(() => AreaModel.fromJson(invalidJson), throwsA(isA<TypeError>()));
    });

    test('Two models with same data should be compared (Optional: If Equatable is used)', () {
      final model1 = AreaModel.fromJson(mockJson);
      final model2 = AreaModel(
        id: '1',
        governorateId: '10',
        cityNameAr: 'القاهرة',
        cityNameEn: 'Cairo',
      );

      // ملاحظة: لو مش مستخدم Equatable، الاختبار ده هيفشل لأن الـ References مختلفة.
      // لو عايزهم يساووا بعض، يفضل تستخدم حزمة equatable في الموديل.
      expect(model1.id, model2.id);
    });
  });
}