import 'package:flutter_test/flutter_test.dart';
import 'package:flowers_app/Features/profile/data/models/generic_section_model.dart'; // تأكدي من المسار

void main() {
  group('GenericSectionModel Tests', () {

    test('should return a valid model when JSON has String content', () {
      // Arrange
      final json = {
        "section": "about",
        "title": {"en": "About Us", "ar": "عننا"},
        "content": {"en": "Some text", "ar": "نص ما"},
        "style": {"fontSize": 14}
      };

      // Act
      final result = GenericSectionModel.fromJson(json);

      // Assert
      expect(result.section, "about");
      expect(result.titleEn, "About Us");
      expect(result.contentEn, isA<String>());
      expect(result.style['fontSize'], 14);
    });

    test('should handle dynamic content as a List', () {
      // Arrange
      final json = {
        "section": "features",
        "content": {
          "en": ["Feature 1", "Feature 2"],
          "ar": ["ميزة 1", "ميزة 2"]
        },
        "style": {}
      };

      // Act
      final result = GenericSectionModel.fromJson(json);

      // Assert
      expect(result.contentEn, isA<List>());
      expect(result.contentEn.length, 2);
    });

    test('should extract titleStyle from style map if it exists', () {
      // Arrange
      final json = {
        "section": "contact",
        "content": {"en": "mail@test.com", "ar": "mail@test.com"},
        "style": {
          "color": "#000000",
          "title": {"fontWeight": "bold"}
        }
      };

      // Act
      final result = GenericSectionModel.fromJson(json);

      // Assert
      expect(result.titleStyle, isNotNull);
      expect(result.titleStyle!['fontWeight'], "bold");
      expect(result.style['color'], "#000000");
    });

    test('should return default values when JSON fields are missing', () {
      // Arrange
      final json = {
        "content": {"en": "test", "ar": "test"},
        "style": null
      };

      // Act
      final result = GenericSectionModel.fromJson(json);

      // Assert
      expect(result.section, ""); // القيمة الافتراضية اللي حطيتيها في الكود
      expect(result.style, isA<Map<String, dynamic>>());
      expect(result.titleStyle, isNull);
    });
  });
}