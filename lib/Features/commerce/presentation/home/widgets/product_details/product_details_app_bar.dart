import 'package:cached_network_image/cached_network_image.dart';
import 'package:flowers_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetailsAppBar extends StatelessWidget {
  final PageController controller;
  final List<String> images;
  final Color backgroundColor;
  final Function(int) onPageChanged;

  const ProductDetailsAppBar({
    super.key,
    required this.controller,
    required this.images,
    required this.backgroundColor,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    final displayImages = images.isEmpty ? [''] : images;

    return SliverAppBar(
      backgroundColor: backgroundColor, // Use dynamic color
      expandedHeight: MediaQuery.of(context).size.height * 0.55,
      elevation: 0,
      pinned: false,
      leading: GestureDetector(
        onTap: () => context.pop(),
        behavior: HitTestBehavior.opaque,
        child: Icon(Icons.arrow_back_ios_new, color: AppColors.black, size: 20),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          color: backgroundColor, // Animate background color change
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              PageView.builder(
                controller: controller,
                itemCount: displayImages.length,
                onPageChanged: onPageChanged,
                itemBuilder: (context, index) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 25.0),
                      child: displayImages[index].isNotEmpty
                          ? CachedNetworkImage(
                              imageUrl: displayImages[index],
                              fit: BoxFit.contain,
                              height: MediaQuery.of(context).size.height * 0.45,
                              placeholder: (context, url) => Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.mainColor,
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error, color: AppColors.gray),
                            )
                          : Icon(
                              Icons.image_not_supported,
                              size: 50,
                              color: AppColors.gray,
                            ),
                    ),
                  );
                },
              ),
              if (displayImages.length > 1)
                Positioned(
                  bottom: 16,
                  child: SmoothPageIndicator(
                    controller: controller,
                    count: displayImages.length,
                    effect: ScrollingDotsEffect(
                      dotHeight: 8,
                      dotWidth: 8,
                      dotColor: AppColors.gray,
                      activeDotColor: AppColors.mainColor,
                      activeDotScale: 1.2,
                      spacing: 8,
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
