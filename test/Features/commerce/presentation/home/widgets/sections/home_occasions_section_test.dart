import 'dart:async';
import 'dart:io';
import 'package:flowers_app/Features/commerce/domain/entities/home_entities/occasion_entity.dart';
import 'package:flowers_app/Features/commerce/presentation/home/widgets/items/occasion_item.dart';
import 'package:flowers_app/Features/commerce/presentation/home/widgets/sections/home_occasions_section.dart';
import 'package:flowers_app/Features/commerce/presentation/home/widgets/shared/section_header.dart';
import 'package:flowers_app/core/l10n/app_localizations.dart';
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
  late List<OccasionEntity> testOccasions;

  setUpAll(() {
    HttpOverrides.global = _MockHttpOverrides();
  });

  setUp(() {
    testOccasions = [
      OccasionEntity(id: '1', name: 'Birthday', imageUrl: 'http://birthday.png'),
      OccasionEntity(id: '2', name: 'Wedding', imageUrl: 'http://wedding.png'),
    ];
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: HomeOccasionsSection(
          occasions: testOccasions,
          screenWidth: 375,
        ),
      ),
    );
  }

  group('HomeOccasionsSection Widget Tests', () {
    testWidgets('Initial State: renders section header and correct number of items', (tester) async {
      // 1. pumpWidget كالعادة
      await tester.pumpWidget(createWidgetUnderTest());

      // 2. بدل pumpAndSettle، استخدمي pump مع مدة زمنية
      // ده بيدي وقت للـ Widgets تظهر بس مش بيستنى الأنيميشن اللانهائي يخلص
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.byType(SectionHeader), findsOneWidget);
      expect(find.byType(OccasionItem), findsNWidgets(testOccasions.length));
      expect(find.text('Birthday'), findsOneWidget);
      expect(find.text('Wedding'), findsOneWidget);
    });

    testWidgets('Empty State: renders nothing when occasions list is empty', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const Scaffold(
            body: HomeOccasionsSection(
              occasions: [],
              screenWidth: 375,
            ),
          ),
        ),
      );

      expect(find.byType(Column), findsNothing);
    });

    testWidgets('Scrolling: verified horizontal axis and scrolling', (tester) async {
      final manyOccasions = List.generate(
        10,
        (index) => OccasionEntity(id: '$index', name: 'Occ $index', imageUrl: 'url'),
      );

      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: HomeOccasionsSection(
              occasions: manyOccasions,
              screenWidth: 375,
            ),
          ),
        ),
      );

      final listViewFinder = find.byType(ListView);
      expect(listViewFinder, findsOneWidget);

      final ListView listView = tester.widget(listViewFinder);
      expect(listView.scrollDirection, Axis.horizontal);

      // Drag horizontally to verify scrollability
      await tester.drag(listViewFinder, const Offset(-200, 0));
      await tester.pump();

      final scrollState = tester.state<ScrollableState>(
        find.descendant(of: listViewFinder, matching: find.byType(Scrollable)),
      );
      expect(scrollState.position.pixels, greaterThan(0));
    });
  });
}
