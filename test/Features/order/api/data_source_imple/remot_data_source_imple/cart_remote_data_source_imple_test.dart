import 'package:flowers_app/Features/order/api/api_client/cart_api.dart';
import 'package:flowers_app/Features/order/api/data_source_imple/remot_data_source_imple/cart_remote_data_source_imple.dart';
import 'package:flowers_app/Features/order/data/models/cart_request_dto.dart';
import 'package:flowers_app/Features/order/data/models/cart_responce_model.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'cart_remote_data_source_imple_test.mocks.dart';

@GenerateMocks([CartApi])
void main() {
  late CartRemoteDataSourceImple cartRemoteDataSourceImple;
  late MockCartApi mockCartApi;

  final tCartResponseModel = CartResponceModel(message: "success");
  final tCartRequest = CartRequest(product: "flowers", quantity: 3);
  setUp(() {
    mockCartApi = MockCartApi();
    cartRemoteDataSourceImple = CartRemoteDataSourceImple(mockCartApi);
  });

  group("CartDataSourceImple Tests", () {
    test(
      'should return SuccessResponse when updateCartItem is successful',
          () async {
        // Arrange
        when(mockCartApi.updateCartProduct(any, any))
            .thenAnswer((_) async => tCartResponseModel);

        // Act
        final result = await cartRemoteDataSourceImple.updateCartItem("123", 4);

        // Assert
        expect(result, isA<CartResponceModel>());
        verify(mockCartApi.updateCartProduct("123", 4)).called(1);
      },
    );

    test(
      'should return SuccessResponse when getCartItem is successful',
          () async {
        // Arrange
        when(mockCartApi.getProductsCart())
            .thenAnswer((_) async => tCartResponseModel);

        // Act
        final result = await cartRemoteDataSourceImple.getCartData();

        // Assert
        expect(result, isA<CartResponceModel>());
        verify(mockCartApi.getProductsCart()).called(1);
      },
    );

    test(
      'should return SuccessResponse when deleteCartItem is successful',
          () async {
        // Arrange
        when(mockCartApi.deleteProductFromCart(any))
            .thenAnswer((_) async => tCartResponseModel);

        // Act
        final result = await cartRemoteDataSourceImple.deleteItemFromCart("123");

        // Assert
        expect(result, isA<CartResponceModel>());
        verify(mockCartApi.deleteProductFromCart("123")).called(1);
      },
    );

    test(
      'should return SuccessResponse when addToCart is successful',
          () async {
        // Arrange
        when(mockCartApi.addProductToCart(any))
            .thenAnswer((_) async => tCartResponseModel);

        // Act
        final result = await cartRemoteDataSourceImple.addToCart(tCartRequest);

        // Assert
        expect(result, isA<CartResponceModel>());
        verify(mockCartApi.addProductToCart(tCartRequest)).called(1);
      },
    );
  });
}