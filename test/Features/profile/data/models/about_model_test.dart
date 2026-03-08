import 'package:flutter_test/flutter_test.dart';
import 'package:flowers_app/Features/profile/data/models/about_model.dart'; // تأكدي من المسار

void main() {
  group('AboutModel Tests', () {
     final tAboutJson = {
      "about_app": [
        {
          "section": "Version",
          "content": {"en": "v1.0.0", "ar": "إصدار ١.٠.٠"},
          "style": {
            "fontSize": 14,
            "color": "#000000",
            "textAlign": {"en": "center", "ar": "center"}
          }
        }
      ]
    };

    test('should return a valid AboutModel from JSON', () {
      // Act
      final result = AboutModel.fromJson(tAboutJson);

      // Assert
      expect(result.aboutApp, isNotNull);
      expect(result.aboutApp!.length, 1);
      expect(result.aboutApp![0].section, "Version");
      expect(result.aboutApp![0].content?.en, "v1.0.0");
      expect(result.aboutApp![0].style?.textAlign?.ar, "center");
    });

    test('toJson should return a Map containing the correct data', () {
      // Arrange
      final model = AboutModel(
        aboutApp: [
          AboutApp(
            section: "Developer",
            content: Content(en: "Flowers Team", ar: "فريق فلاورز"),
          )
        ],
      );

      // Act
      final result = model.toJson();

      // Assert
      expect(result["about_app"], isA<List>());

      final firstItem = result["about_app"][0];
       if (firstItem is Map) {
        expect(firstItem["section"], "Developer");
      } else {
        expect(firstItem.section, "Developer");
      }
    });

    test('should handle null aboutApp list gracefully', () {
      // Arrange
      final json = {"about_app": null};

      // Act
      final result = AboutModel.fromJson(json);

      // Assert
      expect(result.aboutApp, isNull);
    });
  });
}