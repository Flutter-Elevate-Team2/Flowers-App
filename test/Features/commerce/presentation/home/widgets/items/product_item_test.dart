import 'dart:async';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flowers_app/Features/commerce/presentation/home/widgets/items/product_item.dart';
import 'package:flowers_app/core/l10n/app_localizations.dart';
import 'package:flowers_app/core/widget/app_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) => _MockHttpClient();
}

class _MockHttpClient extends Mock implements HttpClient {
  @override
  Future<HttpClientRequest> getUrl(Uri url) async => _MockHttpClientRequest();
}

class _MockHttpClientRequest extends Mock implements HttpClientRequest {
  @override
  HttpHeaders get headers => _MockHttpHeaders();
  @override
  Future<HttpClientResponse> close() async => _MockHttpClientResponse();
}

class _MockHttpClientResponse extends Mock implements HttpClientResponse {
  @override
  int get statusCode => 200;
  @override
  int get contentLength => _transparentImage.length;
  @override
  StreamSubscription<List<int>> listen(void Function(List<int>)? onData,
      {Function? onError, void Function()? onDone, bool? cancelOnError}) {
    return Stream<List<int>>.fromIterable([_transparentImage]).listen(onData,
        onError: onError, onDone: onDone, cancelOnError: cancelOnError);
  }
}

class _MockHttpHeaders extends Mock implements HttpHeaders {}

final List<int> _transparentImage = [
  0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, 0x00, 0x00, 0x00, 0x0D, 0x49,
  0x48, 0x44, 0x52, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01, 0x08, 0x06,
  0x00, 0x00, 0x00, 0x1F, 0x15, 0xC4, 0x89, 0x00, 0x00, 0x00, 0x0A, 0x49, 0x44,
  0x41, 0x54, 0x78, 0x9C, 0x63, 0x00, 0x01, 0x00, 0x00, 0x05, 0x00, 0x01, 0x0D,
  0x0A, 0x2D, 0xB4, 0x00, 0x00, 0x00, 0x00, 0x49, 0x45, 0x4E, 0x44, 0xAE, 0x42,
  0x60, 0x82,
];

void main() {
  setUpAll(() {
    HttpOverrides.global = _MockHttpOverrides();
  });

  Widget createWidgetUnderTest({
    required String name,
    required String price,
    String? imageUrl,
    required double width,
  }) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: ProductItem(
          name: name,
          price: price,
          imageUrl: imageUrl,
          width: width,
        ),
      ),
    );
  }

  group('ProductItem Widget Tests', () {
    const testName = 'Red Rose';
    const testPrice = '100';
    const testWidth = 150.0;

    testWidgets('Initial State: renders name and price correctly', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest(
        name: testName,
        price: testPrice,
        width: testWidth,
      ));

      expect(find.text(testName), findsOneWidget);
      expect(find.text('$testPrice EGP'), findsOneWidget);
    });

    testWidgets('Image: renders CachedNetworkImage when imageUrl is provided', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest(
        name: testName,
        price: testPrice,
        imageUrl: 'https://example.com/rose.png',
        width: testWidth,
      ));

      expect(find.byType(CachedNetworkImage), findsOneWidget);
    });

    testWidgets('Image: renders placeholder icon when imageUrl is null', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest(
        name: testName,
        price: testPrice,
        imageUrl: null,
        width: testWidth,
      ));

      expect(find.byIcon(Icons.image), findsOneWidget);
    });

    testWidgets('Loading State: shows AppShimmer while image is loading', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest(
        name: testName,
        price: testPrice,
        imageUrl: 'https://example.com/rose.png',
        width: testWidth,
      ));

      expect(find.byType(AppShimmer), findsOneWidget);
    });
  });
}
