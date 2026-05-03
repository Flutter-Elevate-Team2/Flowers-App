import 'package:flowers_app/Features/track_order/domain/entities/driver_entity.dart';
import 'package:flowers_app/Features/track_order/domain/entities/order_tracking_entity.dart';
import 'package:flowers_app/Features/track_order/domain/entities/store_entity.dart';
import 'package:flowers_app/Features/track_order/domain/entities/tracking_location_entity.dart';
import 'package:flowers_app/Features/track_order/domain/entities/user_location_entity.dart';
import 'package:flowers_app/Features/track_order/presentation/view_model/track_order_event.dart';
import 'package:flowers_app/Features/track_order/presentation/view_model/track_order_state.dart';
import 'package:flowers_app/Features/track_order/presentation/view_model/track_order_view_model.dart';
import 'package:flowers_app/Features/track_order/presentation/views/order_map_screen.dart';
import 'package:flowers_app/Features/track_order/presentation/widgets/driver_info.dart';
import 'package:flowers_app/Features/track_order/presentation/widgets/estimated_arrival.dart';
import 'package:flowers_app/Features/track_order/presentation/widgets/map/order_map_body.dart';
import 'package:flowers_app/core/di/di.dart';
import 'package:flowers_app/core/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockOrderStatusViewModel extends Mock implements OrderStatusViewModel {}
class FakeBuildContext extends Fake implements BuildContext {}

void main() {
  late MockOrderStatusViewModel mockViewModel;

  final tOrder = OrderTrackingEntity(
    id: "order_123",
    driver: DriverEntity(
      name: "Ahmed Mohamed",
      id: '',
      phone: '',
      token: '',
      vehicleNumber: '',
      vehicleImage: '',
    ),
    orderNumber: '',
    updatedAt: DateTime.now(),
    status: '',
    totalPrice: 120,
    paymentType: '',
    shippingAddress: '',
    trackingLocation: TrackingLocationEntity(lat: 5, long: 16),
    userLocationEntity: UserLocationEntity(lat: 6, long: 7),
    store: StoreEntity(storeLat: 5, storeLong: 15),
  );

  setUpAll(() {
    registerFallbackValue(FakeBuildContext());
    registerFallbackValue(const TrackOrderStatusState());
    registerFallbackValue(FetchOrderDetailsEvent(""));
  });

  setUp(() async {
    mockViewModel = MockOrderStatusViewModel();
    when(() => mockViewModel.close()).thenAnswer((_) async => {});
    when(() => mockViewModel.stream).thenAnswer((_) => const Stream.empty());

    await getIt.reset();
    getIt.registerFactory<OrderStatusViewModel>(() => mockViewModel);
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: OrderMapScreen(order: tOrder),
    );
  }

  group('OrderMapScreen Widget Tests', () {
    testWidgets(
      'should display driver name and essential widgets successfully',
          (tester) async {
        // Set a larger physical size to avoid RenderFlex overflow during testing
        tester.view.physicalSize = const Size(1080, 2400);
        tester.view.devicePixelRatio = 1.0;

        // Arrange
        when(() => mockViewModel.state).thenReturn(const TrackOrderStatusState());
        when(() => mockViewModel.doIntent(any(), any())).thenAnswer((_) async => {});

        // Act
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pumpAndSettle();

        // Assert
        expect(find.byType(OrderMapBody), findsOneWidget);
        expect(find.byType(DriverInfo), findsOneWidget);
        expect(find.textContaining("Ahmed Mohamed"), findsOneWidget);

        // Reset screen size after test
        addTearDown(tester.view.resetPhysicalSize);
      },
    );

    testWidgets(
      'should show estimated arrival time when status history exists in state',
          (tester) async {
        // Arrange
        final historyDate = DateTime.now();
        final stateWithHistory = TrackOrderStatusState(
          statusHistory: {'confirmed': historyDate},
        );

        when(() => mockViewModel.state).thenReturn(stateWithHistory);
        when(() => mockViewModel.doIntent(any(), any())).thenAnswer((_) async => {});

        // Act
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pump();

        // Assert
        expect(find.byType(EstimatedArrival), findsOneWidget);
      },
    );
  });
}