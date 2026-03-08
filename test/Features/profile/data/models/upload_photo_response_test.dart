import 'package:flutter_test/flutter_test.dart';
import 'package:flowers_app/Features/profile/data/models/upload_photo_response.dart';

void main() {
  group('UploadPhotoResponse Tests', () {

    test('should create UploadPhotoResponse from JSON', () {
      // Arrange
      final json = {
        'message': 'Photo uploaded successfully',
        'imageUrl': 'https://example.com/photo.jpg'
      };

      // Act
      final result = UploadPhotoResponse.fromJson(json);

      // Assert
      expect(result.message, 'Photo uploaded successfully');
      expect(result.imageUrl, 'https://example.com/photo.jpg');
    });

    test('should handle null imageUrl in JSON', () {
      // Arrange
      final json = {
        'message': 'Upload failed',
        'imageUrl': null
      };

      // Act
      final result = UploadPhotoResponse.fromJson(json);

      // Assert
      expect(result.imageUrl, isNull);
    });
  });
}