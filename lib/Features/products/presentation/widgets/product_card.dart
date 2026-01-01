import 'package:flowers_app/Features/products/domain/entities/product_entity.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final ProductEntity product;
  final VoidCallback? onTap;

  const ProductCard({super.key, this.onTap, required this.product});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          decoration: _buildContainerBoxDecoration(context),
          child: Padding(
            padding: EdgeInsets.all(screenWidth * 0.02),
            child: InkWell(
              onTap: onTap,
              child: _buildProductCard(constraints, screenWidth, context),
            ),
          ),
        );
      },
    );
  }

  BoxDecoration _buildContainerBoxDecoration(BuildContext context) {
    return BoxDecoration(
      color: Theme.of(context).colorScheme.onPrimary,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        width: .5,
      ),
      boxShadow: [
        BoxShadow(
          color: Theme.of(context).colorScheme.shadow,
          blurRadius: 6,
          offset: const Offset(0, 3),
        ),
      ],
    );
  }

  Column _buildProductCard(
    BoxConstraints constraints,
    double screenWidth,
    BuildContext context,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildProductImage(constraints),
        SizedBox(height: constraints.maxHeight * 0.01),
        _buildProductTitle(screenWidth, context),
        _buildPriceRow(constraints, screenWidth, context),
        const Spacer(),
        _addToCardButton(constraints, context),
      ],
    );
  }

  ClipRRect _buildProductImage(BoxConstraints constraints) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      child: Image.network(
        product.imgCover,
        width: double.infinity,
        height: constraints.maxHeight * 0.5,
        fit: BoxFit.cover,
      ),
    );
  }

  Padding _buildProductTitle(double screenWidth, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
      child: Text(
        product.title.split(' ').take(3).join(' '),
        style: Theme.of(context).textTheme.bodySmall,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Padding _buildPriceRow(
    BoxConstraints constraints,
    double screenWidth,
    BuildContext context,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: constraints.maxHeight * 0.01,
        horizontal: screenWidth * 0.01,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildPrice(context),
          _buildOldPrice(context),
          if (product.discount > 0) _buildDiscount(context),
        ],
      ),
    );
  }

  Flexible _buildDiscount(BuildContext context) {
    return Flexible(
      child: Text(
        '${product.discount}%',
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: Theme.of(context).colorScheme.tertiary,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Flexible _buildOldPrice(BuildContext context) {
    return Flexible(
      child: Text(
        '${product.price}',
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          decoration: TextDecoration.lineThrough,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Flexible _buildPrice(BuildContext context) {
    return Flexible(
      child: Text(
        'EGP ${product.priceAfterDiscount}',
        style: Theme.of(
          context,
        ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  SizedBox _addToCardButton(BoxConstraints constraints, BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: constraints.maxHeight * 0.14,
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.shopping_cart_outlined),
        label: Text((context).l10n.addToCart),
        style: ElevatedButton.styleFrom(
          textStyle: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
