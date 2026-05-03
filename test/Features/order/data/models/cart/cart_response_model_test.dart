import 'package:flowers_app/Features/order/data/models/cart/cart_response_model.dart';
import 'package:flowers_app/Features/order/data/models/cart/cart_dto.dart';
 import 'package:flowers_app/Features/order/data/models/cart/quantity_request.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CartResponseModel Mapping Tests', () {

     final Map<String, dynamic> tCartResponseJson = {
      "message": "success",
      "numOfCartItems": 1,
      "cart": {
        "user": "user_123",
        "_id": "cart_001",
        "totalPrice": 300,
        "createdAt": "2024-05-01",
        "updatedAt": "2024-05-02",
        "__v": 0,
        "appliedCoupons": [],
        "cartItems": [
          {
            "_id": "item_888",
            "price": 150,
            "quantity": 2,
            "product": {
              "_id": "prod_777",
              "title": "Red Roses",
              "price": 150
              // أضف بقية حقول Products حسب تعريفها في الـ DTO الخاص بك
            }
          }
        ]
      }
    };

    test('should return a valid model from JSON (fromJson)', () {
      // Act
      final result = CartResponseModel.fromJson(tCartResponseJson);

      // Assert
      expect(result.message, "success");
      expect(result.numOfCartItems, 1);
      expect(result.cart, isA<Cart>());
      expect(result.cart?.id, "cart_001");
      expect(result.cart?.cartItems?.length, 1);
      expect(result.cart?.cartItems?.first.id, "item_888");
      expect(result.cart?.cartItems?.first.product?.title, "Red Roses");
    });

     test('should return a valid JSON map from model (toJson)', () {
       // Arrange
       final model = CartResponseModel.fromJson(tCartResponseJson);

       // Act
       final resultJson = model.toJson();

       // Assert
       expect(resultJson["message"], tCartResponseJson["message"]);

       // تصحيح الخطأ:
       // بدلاً من الوصول كـ Map، نتحقق من الكائن نفسه أو نقوم بتحويله
       final cartJson = resultJson["cart"];

       if (cartJson is Map) {
         expect(cartJson["user"], tCartResponseJson["cart"]["user"]);
         expect(cartJson["cartItems"][0]["price"], 150);
       } else {
         // إذا كان json_serializable يعيد الـ Instance (حسب الإعدادات)
         expect(cartJson.user, tCartResponseJson["cart"]["user"]);
       }
     });
    test('QuantityRequest should map correctly', () {
      final json = {"quantity": 5};
      final model = QuantityRequest(quantity: 5);

      expect(QuantityRequest.fromJson(json).quantity, 5);
      expect(model.toJson(), json);
    });
  });
}