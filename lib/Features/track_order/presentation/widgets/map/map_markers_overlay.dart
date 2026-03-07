import 'package:flowers_app/core/constants/assets_manager.dart';
import 'package:flutter/material.dart';

class MapMarkersOverlay extends StatelessWidget {
  final ValueNotifier<Offset?> driverOffset;
  final ValueNotifier<Offset?> storeOffset;
  final ValueNotifier<Offset?> userOffset;
  final String? driverImageUrl;

  const MapMarkersOverlay({
    super.key,
    required this.driverOffset,
    required this.storeOffset,
    required this.userOffset,
    this.driverImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildSingleMarker(
          driverOffset,
          AssetsManager.driverLocation,
          50,
          50,
          45,
          35,
          isDriver: true,
          networkImage: driverImageUrl,
        ),

        _buildSingleMarker(
          storeOffset,
          AssetsManager.storeLocation,
          60,
          40,
          30,
          28,
        ),

        _buildSingleMarker(
          userOffset,
          AssetsManager.apartmentLocation,
          75,
          30,
          30,
          25,
        ),
      ],
    );
  }

  Widget _buildSingleMarker(
    ValueNotifier<Offset?> notifier,
    String asset,
    double w,
    double h,
    double offW,
    double offH, {
    bool isDriver = false,
    String? networkImage,
  }) {
    return ValueListenableBuilder<Offset?>(
      valueListenable: notifier,
      builder: (context, offset, _) {
        if (offset == null) return const SizedBox.shrink();

        Widget imageChild;
        if (isDriver && networkImage != null && networkImage.isNotEmpty) {
          imageChild = Image.network(
            networkImage,
            width: w,
            height: h,
            errorBuilder: (context, error, stackTrace) =>
                Image.asset(asset, width: w, height: h),
          );
        } else {
          imageChild = Image.asset(asset, width: w, height: h);
        }

        if (isDriver) {
          return AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.linear,
            left: offset.dx - offW,
            top: offset.dy - offH,
            child: imageChild,
          );
        }

        return Positioned(
          left: offset.dx - offW,
          top: offset.dy - offH,
          child: imageChild,
        );
      },
    );
  }
}
