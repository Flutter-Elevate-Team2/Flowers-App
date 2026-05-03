import 'package:flowers_app/Features/user_address/data/models/add_address_request.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AddAddressRequest Serialization Tests', () {

    test('toJson should return a valid Map with all fields', () {
      // Arrange: تجهيز الطلب ببيانات كاملة
      final request = AddAddressRequest(
        street: 'El-Nasr Street',
        phone: '0123456789',
        city: 'Maadi',
        lat: '29.9602',
        long: '31.2569',
        username: 'ghada_dev',
      );

      // Act: تحويل الـ Object لـ Map
      final json = request.toJson();

      // Assert: التأكد من صحة الـ Keys والقيم
      expect(json['street'], 'El-Nasr Street');
      expect(json['phone'], '0123456789');
      expect(json['city'], 'Maadi');
      expect(json['lat'], '29.9602');
      expect(json['long'], '31.2569');
      expect(json['username'], 'ghada_dev');
    });

    test('toJson should include null values for missing fields', () {
      // Arrange: طلب يحتوي على بعض الحقول فقط
      final request = AddAddressRequest(
        street: 'Tahrir',
        city: 'Cairo',
      );

      // Act
      final json = request.toJson();

      // Assert: التأكد أن الحقول الناقصة موجودة كـ null (السلوك الافتراضي لـ JsonSerializable)
      expect(json['street'], 'Tahrir');
      expect(json['city'], 'Cairo');
      expect(json.containsKey('phone'), true);
      expect(json['phone'], isNull);
      expect(json['lat'], isNull);
    });

    test('Should verify that types are correct in the generated map', () {
      final request = AddAddressRequest(street: '123');
      final json = request.toJson();

      expect(json['street'], isA<String>());
    });
  });
}