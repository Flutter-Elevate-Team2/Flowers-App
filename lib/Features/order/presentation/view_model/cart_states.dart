import 'package:equatable/equatable.dart';
import 'package:flowers_app/Features/order/domain/entities/cart_response_entity.dart';

class CartStates extends Equatable {
  final CartResponseEntity? cartData;
  final Map<String, int> serverQuantities;
  final Map<String, int> optimisticQuantities;
  final Set<String> updatingItemIds;
  final String? errorMessage;
  final String? lastFailedItemId;
  final bool requiresLogin;
  final bool isLoading;

  const CartStates({
    this.cartData,
    this.serverQuantities = const {},
    this.optimisticQuantities = const {},
    this.updatingItemIds = const {},
    this.errorMessage,
    this.lastFailedItemId,
    this.requiresLogin = false,
    this.isLoading = false,
  });

  factory CartStates.fromCart(CartResponseEntity cart) {
    final quantities = <String, int>{};

    for (final item in cart.cart?.cartItems ?? []) {
      final id = item.product?.id;
      if (id != null) {
        quantities[id] = item.quantity ?? 0;
      }
    }

    return CartStates(cartData: cart, serverQuantities: quantities);
  }

  int getDisplayedQuantity(String productId) {
    return optimisticQuantities[productId] ?? serverQuantities[productId] ?? 0;
  }

  CartStates copyWith({
    CartResponseEntity? cartData,
    Map<String, int>? serverQuantities,
    Map<String, int>? optimisticQuantities,
    Set<String>? updatingItemIds,
    String? errorMessage,
    String? lastFailedItemId,
    bool? requiresLogin,
    bool? isLoading,
  }) {
    return CartStates(
      cartData: cartData ?? this.cartData,
      serverQuantities: serverQuantities ?? this.serverQuantities,
      optimisticQuantities: optimisticQuantities ?? this.optimisticQuantities,
      updatingItemIds: updatingItemIds ?? this.updatingItemIds,
      errorMessage: errorMessage,
      lastFailedItemId: lastFailedItemId,
      requiresLogin: requiresLogin ?? this.requiresLogin,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [
    cartData,
    serverQuantities,
    optimisticQuantities,
    updatingItemIds,
    errorMessage,
    lastFailedItemId,
    requiresLogin,
    isLoading,
  ];
}
