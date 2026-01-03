import 'package:cached_network_image/cached_network_image.dart';
import 'package:flowers_app/Features/products/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/l10n/app_localizations.dart';
import '../../../../../core/theming/font_style_manager.dart';
import '../../../../../core/theming/fonts_manager.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductEntity product;
  final PageController controller = PageController();

  ProductDetailsScreen({super.key, required this.product});
  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  late final PageController controller;

  @override
  void initState() {
    super.initState();
    controller = PageController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final images = product.images;
    final locale = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: AppColors.lightPink,
            floating: true,
            leading: GestureDetector(
              child: Icon(Icons.arrow_back_ios),
              onTap: () {
                context.pop();
              },
            ), // custom icon
          ),
          SliverToBoxAdapter(
            child: Container(
              color: AppColors.lightPink,
              height: MediaQuery.of(context).size.height * 0.5,
              child: Column(
                children: [
                  Expanded(
                    child: PageView(
                      controller: controller,
                      children: images
                          .map(
                              (imageUrl) =>
                              CachedNetworkImage(imageUrl: imageUrl,)
                      )
                          .toList(),
                    ),
                  ),
                  SizedBox(height: 8),
                  SmoothPageIndicator(
                    controller: controller,
                    count: images.length,
                    effect: ScrollingDotsEffect(
                      dotHeight: 10,
                      dotWidth: 10,
                      dotColor: AppColors.white[70] ?? AppColors.white,
                      activeDotColor: AppColors.mainColor,
                      activeDotScale: 1.3,
                    ),
                  ),
                  SizedBox(height: 8),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Price and Status Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "EGP ${_formatPrice(product.priceAfterDiscount)}",
                        style: getBoldStyle(
                          color: Colors.black,
                          fontSize: FontSize.s24,
                        ),
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "${locale.status} ",
                              style: getBoldStyle(
                                color: AppColors.black,
                                fontSize: FontSize.s16,
                              ),
                            ),
                            TextSpan(
                              text: product.quantity > 0
                                  ? locale.inStock
                                  : locale.outOfStock,
                              style: getRegularStyle(
                                color: Colors.black,
                                fontSize: FontSize.s16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),

                  // Tax subtitle
                  Text(
                    locale.includeTax,
                    style: getRegularStyle(
                      color: Colors.grey,
                      fontSize: FontSize.s14,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Product Title
                  Text(
                    product.title,
                    style: getBoldStyle(
                      color: AppColors.black,
                      fontSize: FontSize.s18,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Description Section
                  Text(
                    locale.description,
                    style: getBoldStyle(
                      color: AppColors.black,
                      fontSize: FontSize.s16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.description ?? '',
                    style: getRegularStyle(
                      color: Colors.grey[700]!,
                      fontSize: FontSize.s14,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Bouquet Include Section
                  Text(
                    "Bouquet include",
                    style: getBoldStyle(
                      color: AppColors.black,
                      fontSize: FontSize.s16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildBouquetIncludeItem("Pink roses:15"),
                  _buildBouquetIncludeItem("White wrap"),
                  const SizedBox(height: 30),

                  // Add to Cart Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        // addToCart(product);
                      },
                      child: Text(
                        locale.addToCart,
                        style: getSemiBoldStyle(
                          color: Colors.white,
                          fontSize: FontSize.s18,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatPrice(int price) {
    // Format price with thousand separators (e.g., 1500 -> 1,500)
    return price.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
    );
  }

  Widget _buildBouquetIncludeItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        text,
        style: getRegularStyle(
          color: Colors.grey[700]!,
          fontSize: FontSize.s14,
        ),
      ),
    );
  }
}