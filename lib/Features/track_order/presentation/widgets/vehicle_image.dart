import 'package:cached_network_image/cached_network_image.dart';
import 'package:flowers_app/core/widget/app_shimmer.dart';
import 'package:flutter/material.dart';

class VehicleImage extends StatelessWidget {
  final String vehicleImage ;
  const VehicleImage(this.vehicleImage,{super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(vertical: 16),
      child: CachedNetworkImage(
        imageUrl: vehicleImage,
        width: double.infinity,
        fit: BoxFit.fill,
        placeholder: (context, url) => SizedBox(
          width: double.infinity,
          child: Center(
            child: AppShimmer(
              height: MediaQuery.of(context).size.height * 0.2,
              width: double.infinity,
            ),
          ),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }
}
