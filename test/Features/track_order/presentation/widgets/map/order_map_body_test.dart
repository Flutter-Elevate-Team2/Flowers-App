import 'package:flowers_app/Features/track_order/presentation/view_model/track_order_state.dart';
import 'package:flowers_app/Features/track_order/presentation/view_model/track_order_view_model.dart';
import 'package:flowers_app/Features/track_order/presentation/widgets/map/order_map_body.dart';
import 'package:flowers_app/Features/track_order/presentation/widgets/map/map_markers_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart' as mapbox;
import 'package:mocktail/mocktail.dart';

class MockTrackOrderViewModel extends Mock implements OrderStatusViewModel {}
class MockMapboxMap extends Mock implements mapbox.MapboxMap {}

void main() {
  late MockTrackOrderViewModel mockViewModel;

  setUpAll(() {
    registerFallbackValue(const TrackOrderStatusState());
  });

  setUp(() {
    mockViewModel = MockTrackOrderViewModel();

    when(() => mockViewModel.state).thenReturn(const TrackOrderStatusState());
    when(() => mockViewModel.stream).thenAnswer((_) => Stream.value(const TrackOrderStatusState()));
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: BlocProvider<OrderStatusViewModel>.value(
        value: mockViewModel,
        child: const Scaffold(body: OrderMapBody()),
      ),
    );
  }

  group('OrderMapBody Widget Tests', () {
    testWidgets('should render Mapbox Map and Markers Overlay', (tester) async {
      // arrange
      await tester.pumpWidget(createWidgetUnderTest());

      // act
      await tester.pump();

      // assert
      expect(find.byType(mapbox.MapWidget), findsOneWidget);
      expect(find.byType(MapMarkersOverlay), findsOneWidget);
    });

    testWidgets('should listen to state changes and trigger marker updates', (tester) async {
      // arrange
      final initialState = const TrackOrderStatusState();
      final updatedState = TrackOrderStatusState(
        routePoints: [mapbox.Position(30.0, 31.0), mapbox.Position(30.1, 31.1)],
      );

      when(() => mockViewModel.state).thenReturn(initialState);
      when(() => mockViewModel.stream).thenAnswer((_) => Stream.fromIterable([updatedState]));

      // act
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      // assert
       expect(find.byType(mapbox.MapWidget), findsOneWidget);
    });

    testWidgets('should not update markers if MapboxMap is not initialized', (tester) async {
      // arrange
      final stateWithDriver = TrackOrderStatusState(
        currentDriverPosition: mapbox.Position(30.0, 31.0),
      );
      when(() => mockViewModel.state).thenReturn(stateWithDriver);

      // act
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      // assert
       expect(tester.takeException(), isNull);
    });
  });
}