import 'package:flowers_app/Features/order/data/mappers/checkout/cash_chekout_response_mapper.dart';
import 'package:flowers_app/Features/order/data/models/checkout/cash_checkout_response_model.dart';
import 'package:flowers_app/Features/order/data/models/checkout/order_dto.dart';
import 'package:flowers_app/Features/order/domain/entities/checkout/cash_checkout_response_entity.dart';
import 'package:flowers_app/Features/order/domain/entities/checkout/order_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Implement tests for cash_chekout_response_mapper.dart', () {

    // Arrange
    final cashCheckOutResponse = CashCheckoutResponseModel(
        message: "success",
       order: Order(),
    );

    // Act
    final entity = cashCheckOutResponse.toEntity();

    // Assert
    expect(entity, isA<CashCheckoutResponseEntity>());
    expect(entity.message, 'success');
    expect(entity.order, isA<OrderEntity>());
  });
  test('toEntity should handle null CashCheckOutResponse ', () {
    // Arrange
    final cashCheckOutResponse = CashCheckoutResponseModel(
      message: "",
      order: null,
    );

    // Act
    final entity = cashCheckOutResponse.toEntity();

    // Assert
    expect(entity, isA<CashCheckoutResponseEntity>());
    expect(entity.message, "");
    expect(entity.order, null);

  });
}