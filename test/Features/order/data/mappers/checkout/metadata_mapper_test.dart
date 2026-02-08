import 'package:flowers_app/Features/order/data/mappers/checkout/metadata_mapper.dart';
import 'package:flowers_app/Features/order/domain/entities/checkout/orders_metadata_entity.dart';
import 'package:flowers_app/Features/order/data/models/checkout/orders_metadata_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('TODO: Implement tests for metadata_mapper.dart', () {
    // Arrange
    final metadataModel = Metadata(
      currentPage: 1,
      totalItems: 10,
      totalPages: 9,
      limit: 19,
    );

    // Act
    final entity = metadataModel.toEntity();

    // Assert
    expect(entity, isA<OrdersMetadata>());
    expect(entity.currentPage, 1);
    expect(entity.totalItems, 10);
    expect(entity.totalPages, 9);
    expect(entity.limit, 19);
  });
}