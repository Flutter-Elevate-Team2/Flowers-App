import 'package:flutter_test/flutter_test.dart';
import 'package:flowers_app/Features/profile/data/models/terms_conditions_model.dart';

void main() {
  group('TermsAndConditionsModel Tests', () {
    final tTermsJson = {
      "terms_and_conditions": [
        {
          "section": "Privacy",
          "content": {"en": "Privacy Policy", "ar": "سياسة الخصوصية"},
          "style": {
            "fontSize": 16,
            "color": "#FFFFFF",
            "textAlign": {"en": "left", "ar": "right"}
          }
        }
      ]
    };

    test('should return a valid TermsAndConditionsModel from JSON', () {
      // Act
      final result = TermsAndConditionsModel.fromJson(tTermsJson);

      // Assert
      expect(result.termsAndConditions, isNotNull);
      expect(result.termsAndConditions!.length, 1);
      expect(result.termsAndConditions![0].section, "Privacy");
      expect(result.termsAndConditions![0].content?.ar, "سياسة الخصوصية");
    });

    test('toJson should return a proper Map reflecting the model', () {
      // Arrange
      final model = TermsAndConditionsModel(
        termsAndConditions: [
          TermsAndConditions(section: "General")
        ],
      );

      // Act
      final result = model.toJson();

      // Assert
       final firstTerm = result["terms_and_conditions"][0];

      expect(firstTerm.section, "General");
     });  });
}