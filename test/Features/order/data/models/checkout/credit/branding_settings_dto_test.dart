import 'package:flutter_test/flutter_test.dart';
import 'package:flowers_app/Features/order/data/models/checkout/credit/branding_settings_dto.dart';
import 'package:flowers_app/Features/order/data/models/checkout/credit/shared_models.dart';

void main() {
  group('BrandingSettings DTO Tests', () {

    test('should parse branding settings from JSON correctly', () {
      final json = {
        'background_color': '#FFFFFF',
        'button_color': '#00FF00',
        'display_name': 'Flowers App Store',
        'font_family': 'Roboto',
        'icon': {'url': 'https://test.com/icon.png'}, // Assuming Icon has a url field
        'logo': {'url': 'https://test.com/logo.png'}
      };

      final result = BrandingSettings.fromJson(json);

      expect(result.backgroundColor, '#FFFFFF');
      expect(result.displayName, 'Flowers App Store');
      expect(result.icon, isA<Icon>());
      expect(result.logo, isA<Logo>());
    });

    test('should return null for missing optional fields', () {
      final json = {'display_name': 'Only Name'};
      final result = BrandingSettings.fromJson(json);

      expect(result.displayName, 'Only Name');
      expect(result.backgroundColor, isNull);
      expect(result.icon, isNull);
    });

    test('should convert BrandingSettings back to JSON', () {
      final branding = BrandingSettings(
        displayName: 'Test Store',
        buttonColor: '#123456',
      );

      final json = branding.toJson();

      expect(json['display_name'], 'Test Store');
      expect(json['button_color'], '#123456');
    });
  });
}