import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/l10n/app_localizations.dart';
import '../../../../../core/theming/font_style_manager.dart';
import '../../../../../core/theming/fonts_manager.dart';

class ProductDetailsScreen extends StatelessWidget {
  final PageController controller = PageController();
final  int quantity=7;

   ProductDetailsScreen({super.key,});
  @override
  Widget build(BuildContext context) {
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
                Navigator.pop(context);
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
                      children:[
                        "https://www.flowerpowerdesign.com/wp-content/uploads/2025/08/Pink-Symphony-600x600.jpg",
                        "https://i0.wp.com/www.southsideblooms.com/wp-content/uploads/2021/12/pexels-lisa-2106037-scaled.jpg?w=1708&ssl=1"] //product.images!
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
                    count:7,
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
                      Text("600 ${locale.egp} ",
                          style: getSemiBoldStyle(
                              color:Colors.black, fontSize: FontSize.s20)),
                      Text.rich(TextSpan(children: [
                        TextSpan(
                            text: locale.status,
                            style: getBoldStyle(
                                color: AppColors.black,
                                fontSize: FontSize.s20)),
                        TextSpan(
                            text: (quantity<0)
                                ? locale.inStock
                                : locale.outOfStock,
                            style: getMediumStyle(
                                color: Colors.black,
                                fontSize: FontSize.s16)),
                      ]))
                    ],
                  ),
                  SizedBox(height: 5),
                  Text(locale.includeTax,
                      style: getRegularStyle(
                          color: AppColors.gray, fontSize: FontSize.s13)),
                  SizedBox(height: 5),
                  Text("15 Pink Rose Bouquet",
                      style: getBoldStyle(
                          color: AppColors.black, fontSize: FontSize.s16)),
                  SizedBox(height:15),
                  Text(locale.description,
                      style: getBoldStyle(
                          color: AppColors.black, fontSize: FontSize.s16)),
                  SizedBox(height:5),
                  Text("Lorem ipsum dolor sit amet consectetur. Id sit morbi ornare morbi duis rhoncus orci massa.",
                      style: getMediumStyle(
                          color: AppColors.black, fontSize: FontSize.s16)),
                  SizedBox(height: 90),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(locale.addToCart,
                          style: getMediumStyle(
                              color: Colors.white, fontSize: FontSize.s18)),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}