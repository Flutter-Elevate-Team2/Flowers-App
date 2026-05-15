import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AppShimmer extends StatelessWidget {
  final double width;
  final double height;
  final double radius;
  final ShapeBorder shapeBorder;

  const AppShimmer({
    super.key,
    this.width = double.infinity,
    required this.height,
    this.radius = 12,
    this.shapeBorder = const RoundedRectangleBorder(),
  });

  const AppShimmer.circle({super.key, required double size})
    : width = size,
      height = size,
      radius = size / 2,
      shapeBorder = const CircleBorder();

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).primaryColor.withValues(alpha: 0.2),
      highlightColor: Theme.of(context).primaryColor.withValues(alpha: 0.05),

      child: Container(
        width: width,
        height: height,
        decoration: ShapeDecoration(
          color: Theme.of(context).primaryColor,
          shape: shapeBorder == const CircleBorder()
              ? shapeBorder
              : RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(radius),
                ),
        ),
      ),
    );
  }
}
