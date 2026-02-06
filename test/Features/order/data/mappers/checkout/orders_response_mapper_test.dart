import 'package:flowers_app/Features/order/data/mappers/checkout/orders_response_mapper.dart';
import 'package:flowers_app/Features/order/data/models/checkout/orders_metadata_dto.dart';
import 'package:flowers_app/Features/order/data/models/checkout/user_orders_dto.dart';
import 'package:flowers_app/Features/order/domain/entities/checkout/order_entity.dart';
import 'package:flowers_app/Features/order/domain/entities/checkout/orders_metadata_entity.dart';
import 'package:flowers_app/Features/order/domain/entities/checkout/user_orders_response_entity.dart';
import 'package:flowers_app/Features/order/data/models/checkout/user_orders_response_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Implement tests for orders_response_mapper.dart', () {

        // Arrange
        final orderResponse = UserOrdersResponseModel(
         message: "success",
          orders:List<Orders>.empty(),
          metadata: Metadata()
        );

        // Act
        final entity = orderResponse.toEntity();

        // Assert
        expect(entity, isA<UserOrdersResponseEntity>());
        expect(entity.message, 'success');
        expect(entity.orders, everyElement(isA<OrderEntity>()));
        expect(entity.metadata, isA<OrdersMetadata>());
      });
    }