import 'package:flowers_app/Features/products/data/mappers/meta_data_mapper.dart';
import 'package:flowers_app/Features/products/domain/entities/meta_data_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flowers_app/Features/products/data/models/products_model/products_response.dart';

void main() {
  group('MetaDateMapper Tests', () {
    test(
      'should map MetaData model to MetaDataEntity correctly when all fields are present',
      () {
        // Arrange
        final metaData = Metadata(
          limit: 10,
          currentPage: 1,
          totalItems: 20,
          totalPages: 2,
        );

        // Act
        final MetaDataEntity entity = metaData.toEntity();

        // Assert
        expect(entity.limit, 10);
        expect(entity.currentPage, 1);
        expect(entity.totalItems, 20);
        expect(entity.totalPages, 2);
      },
    );

    test(
      'should return default values when MetaData model has null fields',
      () {
        // Arrange
        final metaData = Metadata();

        // Act
        final MetaDataEntity entity = metaData.toEntity();

        // Assert
        expect(entity.limit, 20);
        expect(entity.currentPage, 1);
        expect(entity.totalItems, 0);
        expect(entity.totalPages, 1);
      },
    );
  });
}
