import 'package:cached_network_image/cached_network_image.dart';
import 'package:flowers_app/Features/commerce/domain/entities/product_entities/product_entity.dart';
import 'package:flowers_app/Features/commerce/presentation/home/widgets/product_details/product_details_app_bar.dart';
import 'package:flowers_app/Features/commerce/presentation/home/widgets/product_details/product_details_bottom_bar.dart';
import 'package:flowers_app/Features/commerce/presentation/home/widgets/product_details/product_details_content.dart';
import 'package:flowers_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductEntity product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  late final PageController _controller;
  Color _backgroundColor = AppColors.lightPink;

  @override
  void initState() {
    super.initState();
    _controller = PageController();

    // Initial color update for the first image
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.product.images.isNotEmpty) {
        _updatePalette(0);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _updatePalette(int index) async {
    final images = widget.product.images;
    if (images.isEmpty || index >= images.length) return;

    final imageUrl = images[index];
    if (imageUrl.isEmpty) return;

    try {
      final paletteGenerator = await PaletteGenerator.fromImageProvider(
        CachedNetworkImageProvider(imageUrl),
        maximumColorCount: 20,
      );

      if (mounted) {
        setState(() {
          // Try to get a light muted color, fallback to dominant, then default
          _backgroundColor =
              paletteGenerator.lightMutedColor?.color ??
              paletteGenerator.dominantColor?.color.withValues(alpha: 0.3) ??
              AppColors.lightPink;

          // Ensure the background is light enough for black text/icons content
          if (ThemeData.estimateBrightnessForColor(_backgroundColor) ==
              Brightness.dark) {
            _backgroundColor = Color.alphaBlend(
              Colors.white.withValues(alpha: 0.8),
              _backgroundColor,
            );
          }
        });
      }
    } catch (e) {
      // Fallback on error
      debugPrint('Error generating palette: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  ProductDetailsAppBar(
                    controller: _controller,
                    images: widget.product.images,
                    backgroundColor: _backgroundColor,
                    onPageChanged: _updatePalette,
                  ),
                  ProductDetailsContent(product: widget.product),
                ],
              ),
            ),
            ProductDetailsBottomBar(
              product: widget.product,
            ),
          ],
        ),
      ),
    );
  }
}
