import 'package:flowers_app/Features/order/api/api_client/order_api.dart';
import 'package:flowers_app/Features/order/api/data_source_imple/remot_data_source_imple/order_remote_data_source_imple.dart';
import 'package:flowers_app/Features/order/data/models/cart/cart_request_dto.dart';
import 'package:flowers_app/Features/order/data/models/cart/cart_response_model.dart';
import 'package:flowers_app/Features/order/data/models/cart/quantity_request.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'order_remote_data_source_imple_test.mocks.dart';

@GenerateMocks([OrderApi])
void main() {
  late OrderRemoteDataSourceImple orderRemoteDataSourceImple;
  late MockOrderApi mockOrderApi;

  final tCartResponseModel = CartResponseModel(message: "success");
  final tCartRequest = CartRequest(product: "flowers", quantity: 3);
  setUp(() {
    mockOrderApi = MockOrderApi();
    orderRemoteDataSourceImple = OrderRemoteDataSourceImple(mockOrderApi);
  });

  group("OrderDataSourceImple Tests", () {
    test(
      'should return SuccessResponse when updateCartItem is successful',
      () async {
        // Arrange
        when(
          mockOrderApi.updateCartProduct(any, any),
        ).thenAnswer((_) async => tCartResponseModel);

        // Act
        final result = await orderRemoteDataSourceImple.updateCartItem(
          "123",
          QuantityRequest(quantity: 4),
        );

        // Assert
        expect(result, isA<CartResponseModel>());
        verify(
          mockOrderApi.updateCartProduct(
            "123",
            argThat(
              isA<QuantityRequest>().having((q) => q.quantity, 'quantity', 4),
            ),
          ),
        ).called(1);
      },
    );

    test(
      'should return SuccessResponse when getCartItem is successful',
      () async {
        // Arrange
        when(
          mockOrderApi.getProductsCart(),
        ).thenAnswer((_) async => tCartResponseModel);

        // Act
        final result = await orderRemoteDataSourceImple.getCartData();

        // Assert
        expect(result, isA<CartResponseModel>());
        verify(mockOrderApi.getProductsCart()).called(1);
      },
    );

    test(
      'should return SuccessResponse when deleteCartItem is successful',
      () async {
        // Arrange
        when(
          mockOrderApi.deleteProductFromCart(any),
        ).thenAnswer((_) async => tCartResponseModel);

        // Act
        final result = await orderRemoteDataSourceImple.deleteItemFromCart(
          "123",
        );

        // Assert
        expect(result, isA<CartResponseModel>());
        verify(mockOrderApi.deleteProductFromCart("123")).called(1);
      },
    );

    test(
      'should return SuccessResponse when addToCart is successful',
      () async {
        // Arrange
        when(
          mockOrderApi.addProductToCart(any),
        ).thenAnswer((_) async => tCartResponseModel);

        // Act
        final result = await orderRemoteDataSourceImple.addToCart(tCartRequest);

        // Assert
        expect(result, isA<CartResponseModel>());
        verify(mockOrderApi.addProductToCart(tCartRequest)).called(1);
      },
    );
  });
}
