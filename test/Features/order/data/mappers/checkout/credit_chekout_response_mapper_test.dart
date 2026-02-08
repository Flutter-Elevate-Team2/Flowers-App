import 'package:flowers_app/Features/order/data/mappers/checkout/credit_chekout_response_mapper.dart';
import 'package:flowers_app/Features/order/data/models/checkout/credit/credit_checkout_response_model.dart';
import 'package:flowers_app/Features/order/data/models/checkout/credit/session_dto.dart';
import 'package:flowers_app/Features/order/domain/entities/checkout/credit_checkout_response_entity.dart';
import 'package:flowers_app/Features/order/domain/entities/checkout/session_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Implement tests for credit_chekout_response_mapper.dart', () {

    // Arrange
    final creditCheckOutResponse = CreditCheckoutResponseModel(
      message: "success",
      session: Session(),
    );

    // Act
    final entity = creditCheckOutResponse.toEntity();

    // Assert
    expect(entity, isA<CreditCheckoutResponseEntity>());
    expect(entity.message, 'success');
    expect(entity.session, isA<SessionEntity>());
  });
  test('toEntity should handle null CreditCheckOutResponse ', () {
    // Arrange
    final creditCheckOutResponse = CreditCheckoutResponseModel(
      message: "",
      session: null,
    );

    // Act
    final entity = creditCheckOutResponse.toEntity();

    // Assert
    expect(entity, isA<CreditCheckoutResponseEntity>());
    expect(entity.message, "");
    expect(entity.session, null);

  });
}