import 'package:flowers_app/Features/commerce/presentation/products/widgets/shared/product_card/product_card_image.dart';
 import 'package:flowers_app/core/constants/app_colors.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flowers_app/core/widget/custom_button.dart';
import 'package:flowers_app/core/widget/date_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flowers_app/Features/order/domain/entities/checkout/user_orders_entity.dart';

class OrderCard extends StatelessWidget {
  final OrdersEntity order;
  final bool isCompleted;
  final VoidCallback onButtonPressed;
  final String? locale;

  const OrderCard({
    required this.order,
    required this.isCompleted,
    required this.onButtonPressed,
    this.locale,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(top: 16, left: 28, right: 28),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.gray, style: BorderStyle.solid),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.37,
              child: ProductCardImage(
                imgCover: order.orderItems?.first.product!.imgCover ?? "",
                height: MediaQuery.of(context).size.height * .15,
                bottomRadius: 12,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      order.orderItems?.first.product!.title ?? "",
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "${context.l10n.egp} ${order.totalPrice}",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: AppColors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      isCompleted
                          ? '${context.l10n.deliveredOn} ${formatDate(order.updatedAt ?? "", locale: locale)}'
                          : '${context.l10n.orderNumber} ${order.orderNumber}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontSize: 12,
                        color: AppColors.gray,
                      ),
                    ),
                    const SizedBox(height: 16),
                     isCompleted
                          ? CustomButton(
                              title: context.l10n.reorder,
                              onPressed: onButtonPressed,
                            )
                          : CustomButton(
                              title: context.l10n.trackOrder,
                              onPressed:onButtonPressed
                            ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
