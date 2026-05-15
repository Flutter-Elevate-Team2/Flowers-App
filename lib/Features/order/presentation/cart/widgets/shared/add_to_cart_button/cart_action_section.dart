import 'package:flowers_app/Features/commerce/domain/entities/product_entities/product_entity.dart';
import 'package:flowers_app/Features/order/data/models/cart/cart_request_dto.dart';
import 'package:flowers_app/Features/order/data/models/cart/quantity_request.dart';
import 'package:flowers_app/Features/order/presentation/cart/view_model/cart_events.dart';
import 'package:flowers_app/Features/order/presentation/cart/view_model/cart_states.dart';
import 'package:flowers_app/Features/order/presentation/cart/view_model/cart_view_model.dart';
import 'package:flowers_app/Features/order/presentation/cart/widgets/shared/cart_action_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartActionSection extends StatelessWidget {
  final ProductEntity product;
  final CartActionStyle style;

  const CartActionSection({
    super.key,
    required this.product,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    final vm = context.read<CartViewModel>();

    return BlocListener<CartViewModel, CartStates>(
      listener: (context, state) {
        if (state.lastFailedItemId == product.id &&
            state.errorMessage != null) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(state.errorMessage!)));
        }
      },
      child: BlocBuilder<CartViewModel, CartStates>(
        buildWhen: (prev, curr) {
          return prev.getDisplayedQuantity(product.id) !=
                  curr.getDisplayedQuantity(product.id) ||
              prev.updatingItemIds.contains(product.id) !=
                  curr.updatingItemIds.contains(product.id);
        },
        builder: (context, state) {
          final quantity = state.getDisplayedQuantity(product.id);

          final isLoading =
              state.updatingItemIds.contains(product.id) ||
              state.optimisticQuantities.containsKey(product.id);

          if (product.quantity <= 0) {
            return style.buildSoldOut(context);
          }

          final isIncrementDisabled = isLoading || quantity >= product.quantity;

          final isDecrementDisabled = isLoading;

          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 150),
            child: quantity > 0
                ? style.buildQuantitySelector(
                    context,
                    key: const ValueKey('quantity'),
                    quantity: quantity,
                    isLoading: isLoading,

                    isIncrementDisabled: isIncrementDisabled,
                    isDecrementDisabled: isDecrementDisabled,

                    onIncrement: () => vm.doIntent(
                      UpdateCartItemEvent(
                        itemId: product.id,
                        quantityRequest: QuantityRequest(
                          quantity: quantity + 1,
                        ),
                      ),
                    ),
                    onDecrement: () => vm.doIntent(
                      UpdateCartItemEvent(
                        itemId: product.id,
                        quantityRequest: QuantityRequest(
                          quantity: quantity - 1,
                        ),
                      ),
                    ),
                    onDelete: () =>
                        vm.doIntent(DeleteCartItemEvent(product.id)),
                  )
                : style.buildAddButton(
                    context,
                    key: const ValueKey('add'),
                    isLoading: isLoading,
                    onAdd: () => vm.doIntent(
                      AddToCartEvent(
                        CartRequest(product: product.id, quantity: 1),
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }
}
