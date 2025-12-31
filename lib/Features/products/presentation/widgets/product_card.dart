import 'package:flowers_app/Features/products/domain/entities/product_entity.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final ProductEntity product;
  final VoidCallback? onTap;

  const ProductCard({
    super.key,
    this.onTap,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsetsGeometry.all(8),
        child: InkWell(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                child: Image.network(
                  product.imgCover,
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.16,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 8,),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                    product.title.split(' ').take(3).join(' '),
                    style: Theme.of(context).textTheme.bodySmall),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8 , horizontal: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'EGP ${product.priceAfterDiscount}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${product.price}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(
                          context,
                        ).colorScheme.surfaceContainerHighest,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    if (product.discount > 0)
                      Text(
                          '${product.discount}%',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.tertiary,
                          ))
                    else SizedBox(),
                  ],
                ),
              ),
              Spacer(),
              SizedBox(
                width: double.infinity,
                height: 36,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon:  Icon(Icons.shopping_cart_outlined),
                  label:  Text((context).l10n.addToCart),
                  style: ElevatedButton.styleFrom(
                      textStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,)
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
