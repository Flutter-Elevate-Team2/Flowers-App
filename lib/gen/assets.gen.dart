// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/Delivery Boy.svg
  String get deliveryBoy => 'assets/icons/Delivery Boy.svg';

  /// File path: assets/icons/Photo.svg
  String get photo => 'assets/icons/Photo.svg';

  /// File path: assets/icons/flower_logo.svg
  String get flowerLogo => 'assets/icons/flower_logo.svg';

  /// File path: assets/icons/location-dot.svg
  String get locationDot => 'assets/icons/location-dot.svg';

  /// List of all assets
  List<String> get values => [deliveryBoy, photo, flowerLogo, locationDot];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/Rectangle.png
  AssetGenImage get rectangle =>
      const AssetGenImage('assets/images/Rectangle.png');

  /// File path: assets/images/apartment_location.png
  AssetGenImage get apartmentLocation =>
      const AssetGenImage('assets/images/apartment_location.png');

  /// File path: assets/images/app_logo.png
  AssetGenImage get appLogo =>
      const AssetGenImage('assets/images/app_logo.png');

  /// File path: assets/images/driver_location.png
  AssetGenImage get driverLocation =>
      const AssetGenImage('assets/images/driver_location.png');

  /// File path: assets/images/flower.png
  AssetGenImage get flower => const AssetGenImage('assets/images/flower.png');

  /// File path: assets/images/flowery-removebg-preview.png
  AssetGenImage get floweryRemovebgPreview =>
      const AssetGenImage('assets/images/flowery-removebg-preview.png');

  /// File path: assets/images/icons8-location-48.png
  AssetGenImage get icons8Location48 =>
      const AssetGenImage('assets/images/icons8-location-48.png');

  /// File path: assets/images/location marker.png
  AssetGenImage get locationMarker =>
      const AssetGenImage('assets/images/location marker.png');

  /// File path: assets/images/location_point.png
  AssetGenImage get locationPoint =>
      const AssetGenImage('assets/images/location_point.png');

  /// File path: assets/images/motorcycle_delivery.png
  AssetGenImage get motorcycleDelivery =>
      const AssetGenImage('assets/images/motorcycle_delivery.png');

  /// File path: assets/images/store_location.png
  AssetGenImage get storeLocation =>
      const AssetGenImage('assets/images/store_location.png');

  /// File path: assets/images/user_location.png
  AssetGenImage get userLocation =>
      const AssetGenImage('assets/images/user_location.png');

  /// List of all assets
  List<AssetGenImage> get values => [
    rectangle,
    apartmentLocation,
    appLogo,
    driverLocation,
    flower,
    floweryRemovebgPreview,
    icons8Location48,
    locationMarker,
    locationPoint,
    motorcycleDelivery,
    storeLocation,
    userLocation,
  ];
}

class $AssetsJsonGen {
  const $AssetsJsonGen();

  /// File path: assets/json/Flowery About Section JSON with Expanded Content.json
  String get floweryAboutSectionJSONWithExpandedContent =>
      'assets/json/Flowery About Section JSON with Expanded Content.json';

  /// File path: assets/json/Flowery Terms and Conditions JSON with Arabic and English.json
  String get floweryTermsAndConditionsJSONWithArabicAndEnglish =>
      'assets/json/Flowery Terms and Conditions JSON with Arabic and English.json';

  /// File path: assets/json/tracking-app-service.json
  String get trackingAppService => 'assets/json/tracking-app-service.json';

  /// List of all assets
  List<String> get values => [
    floweryAboutSectionJSONWithExpandedContent,
    floweryTermsAndConditionsJSONWithArabicAndEnglish,
    trackingAppService,
  ];
}

class $AssetsLottieGen {
  const $AssetsLottieGen();

  /// File path: assets/lottie/Delivery.json
  String get delivery => 'assets/lottie/Delivery.json';

  /// File path: assets/lottie/Error animation.json
  String get errorAnimation => 'assets/lottie/Error animation.json';

  /// File path: assets/lottie/Login.json
  String get login => 'assets/lottie/Login.json';

  /// File path: assets/lottie/cities.json
  String get cities => 'assets/lottie/cities.json';

  /// File path: assets/lottie/empty_cart.json
  String get emptyCart => 'assets/lottie/empty_cart.json';

  /// File path: assets/lottie/order fail.json
  String get orderFail => 'assets/lottie/order fail.json';

  /// File path: assets/lottie/payment_success.json
  String get paymentSuccess => 'assets/lottie/payment_success.json';

  /// File path: assets/lottie/states (1).json
  String get states1 => 'assets/lottie/states (1).json';

  /// List of all assets
  List<String> get values => [
    delivery,
    errorAnimation,
    login,
    cities,
    emptyCart,
    orderFail,
    paymentSuccess,
    states1,
  ];
}

class Assets {
  const Assets._();

  static const String aEnv = '.env';
  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsJsonGen json = $AssetsJsonGen();
  static const $AssetsLottieGen lottie = $AssetsLottieGen();

  /// List of all assets
  static List<String> get values => [aEnv];
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
    this.animation,
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class AssetGenImageAnimation {
  const AssetGenImageAnimation({
    required this.isAnimation,
    required this.duration,
    required this.frames,
  });

  final bool isAnimation;
  final Duration duration;
  final int frames;
}
