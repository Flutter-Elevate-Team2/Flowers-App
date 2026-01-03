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
                                Image.network(imageUrl, fit: BoxFit.contain),
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
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${product.priceAfterDiscount} ${locale.egp}",
                        style: getSemiBoldStyle(
                          color: Colors.black,
                          fontSize: FontSize.s20,
                        ),
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: locale.status,
                              style: getBoldStyle(
                                color: AppColors.black,
                                fontSize: FontSize.s20,
                              ),
                            ),
                            TextSpan(
                              text: product.quantity > 0
                                  ? locale.inStock
                                  : locale.outOfStock,
                              style: getMediumStyle(
                                color: Colors.black,
                                fontSize: FontSize.s16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Text(
                    locale.includeTax,
                    style: getRegularStyle(
                      color: AppColors.gray,
                      fontSize: FontSize.s13,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    product.title,
                    style: getBoldStyle(
                      color: AppColors.black,
                      fontSize: FontSize.s16,
                    ),
                  ),

                  SizedBox(height: 15),
                  Text(
                    locale.description,
                    style: getBoldStyle(
                      color: AppColors.black,
                      fontSize: FontSize.s16,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    product.description ,
                    style: getMediumStyle(
                      color: AppColors.black,
                      fontSize: FontSize.s16,
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        // addToCart(product);
                      },
                      child: Text(
                        locale.addToCart,
                        style: getMediumStyle(
                          color: Colors.white,
                          fontSize: FontSize.s18,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
