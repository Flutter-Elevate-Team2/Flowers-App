import 'package:flowers_app/Features/track_order/domain/entities/driver_entity.dart';
import 'package:flowers_app/Features/track_order/domain/entities/order_status.dart';
import 'package:flowers_app/Features/track_order/domain/entities/order_tracking_entity.dart';
import 'package:flowers_app/Features/track_order/domain/entities/store_entity.dart';
import 'package:flowers_app/Features/track_order/domain/entities/tracking_location_entity.dart';
import 'package:flowers_app/Features/track_order/domain/entities/user_location_entity.dart';
import 'package:flowers_app/Features/track_order/presentation/view_model/track_order_state.dart';
import 'package:flowers_app/Features/track_order/presentation/view_model/track_order_view_model.dart';
import 'package:flowers_app/Features/track_order/presentation/views/accepted_order_screen.dart';
import 'package:flowers_app/core/app_router/app_router.dart';
import 'package:flowers_app/core/base_states/base_states.dart';
import 'package:flowers_app/core/l10n/app_localizations.dart';
import 'package:flowers_app/core/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:lottie/lottie.dart';

import 'accepted_order_screen_test.mocks.dart';

@GenerateMocks([OrderStatusViewModel])
void main() {
  late MockOrderStatusViewModel mockViewModel;
  const tOrderId = "order_123";

  setUp(() {
    mockViewModel = MockOrderStatusViewModel();
    when(mockViewModel.state).thenReturn(const TrackOrderStatusState());
    when(mockViewModel.stream).thenAnswer((_) => const Stream.empty());
    when(mockViewModel.close()).thenAnswer((_) async => {});
  });

  Widget createWidgetUnderTest({GoRouter? router}) {
    final testRouter =
        router ??
        GoRouter(
          initialLocation: '/accepted',
          routes: [
            GoRoute(
              path: '/accepted',
              name: Routes.placedSuccessfullyName,
              builder: (context, state) =>
                  BlocProvider<OrderStatusViewModel>.value(
                    value: mockViewModel,
                    child: const AcceptedOrderScreen(orderId: tOrderId),
                  ),
            ),
            GoRoute(
              path: '/track/:orderId',
              name: Routes.trackOrderName,
              builder: (context, state) =>
                  const Scaffold(body: Text('Track Order Page')),
            ),
          ],
        );

    return MaterialApp.router(
      routerConfig: testRouter,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }

  group('AcceptedOrderScreen Widget Tests', () {
    testWidgets('Should display Lottie animation and success message', (
      tester,
    ) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(Lottie), findsOneWidget);

      final context = tester.element(find.byType(AcceptedOrderScreen));
      expect(
        find.text(AppLocalizations.of(context)!.placedSuccessfully),
        findsOneWidget,
      );
    });

    testWidgets('Button should be disabled when order status is NOT accepted', (
      tester,
    ) async {
      when(mockViewModel.state).thenReturn(
        const TrackOrderStatusState(
          orderState: BaseState(data: null),
        ),
      );

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      final button = tester.widget<CustomButton>(find.byType(CustomButton));
      expect(button.onPressed, isNull);
    });

    testWidgets(
      'Button should be enabled and navigate when order status is accepted',
      (tester) async {
        final tOrderData = OrderTrackingEntity(
          id: tOrderId,
          status: OrderStatus.accepted.name, // "accepted"
           updatedAt: DateTime.now(),
          totalPrice: 100,
          orderNumber: '',
          paymentType: '',
          shippingAddress: '',
          trackingLocation: TrackingLocationEntity(lat: 5, long: 6),
          userLocationEntity: UserLocationEntity(lat: 5, long: 10),
          driver: DriverEntity(
            id: "id",
            name: "name",
            phone: "phone",
            token: "token",
            vehicleNumber: "vehicleNumber",
            vehicleImage: "vehicleImage",
          ),
            store: StoreEntity(
              storeLat: 7.0,
              storeLong: 12.5,
            )
        );

         when(mockViewModel.state).thenReturn(
          TrackOrderStatusState(
            orderState: BaseState(data: tOrderData),
          ),
        );

        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pumpAndSettle();


         final buttonFinder = find.byType(CustomButton);
        expect(buttonFinder, findsOneWidget);

        await tester.tap(buttonFinder);
        await tester.pumpAndSettle();

         expect(find.text('Track Order Page'), findsOneWidget);
      },
    );
  });
}

class MockOrderData {
  final String status;
  MockOrderData({required this.status});
}
