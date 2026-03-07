import 'package:flowers_app/Features/track_order/domain/entities/driver_entity.dart';
import 'package:flowers_app/Features/track_order/domain/entities/tracking_location_entity.dart';
import 'package:flowers_app/Features/track_order/domain/entities/user_location_entity.dart';
 import 'package:flowers_app/Features/track_order/presentation/view_model/track_order_state.dart';
import 'package:flowers_app/Features/track_order/presentation/view_model/track_order_view_model.dart';
import 'package:flowers_app/Features/track_order/presentation/views/track_order_screen.dart';
 import 'package:flowers_app/Features/track_order/presentation/widgets/track_order_shimmer.dart';
import 'package:flowers_app/Features/track_order/presentation/widgets/driver_info.dart';
import 'package:flowers_app/Features/track_order/domain/entities/order_tracking_entity.dart';
 import 'package:flowers_app/core/base_states/base_states.dart';
import 'package:flowers_app/core/di/di.dart';
import 'package:flowers_app/core/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:go_router/go_router.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'track_order_body_test.mocks.dart';

 @GenerateMocks([OrderStatusViewModel])


void main() {
  late MockOrderStatusViewModel mockViewModel;
  const tOrderId = "order_123";

  setUp(() async {
    mockViewModel = MockOrderStatusViewModel();

    // إعداد التخلص من الـ ViewModel
    when(mockViewModel.close()).thenAnswer((_) async => {});

    // إعادة ضبط حقن التبعيات وتسجيل الموك
    await getIt.reset();
    getIt.registerFactory<OrderStatusViewModel>(() => mockViewModel);
  });

  /// إنشاء بيئة الاختبار مع GoRouter مهيأ بشكل صحيح
  Widget createWidgetUnderTest() {
    final router = GoRouter(
      initialLocation: '/track',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const Scaffold(body: Center(child: Text('Home'))),
        ),
        GoRoute(
          path: '/track',
          builder: (context, state) => const TrackOrderScreen(orderId: tOrderId),
        ),
      ],
    );

    return MaterialApp.router(
      routerConfig: router,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }

  group('TrackOrderBody & Screen Widget Tests', () {
    testWidgets('Should show TrackOrderShimmer when state is loading', (tester) async {
      // Arrange
      final loadingState = TrackOrderStatusState(
        orderState: BaseState(isLoading: true),
      );

      when(mockViewModel.state).thenReturn(loadingState);
      when(mockViewModel.stream).thenAnswer((_) => Stream.value(loadingState));

      // Act
      await tester.pumpWidget(createWidgetUnderTest());
      // لا نستخدم pumpAndSettle هنا لأن Shimmer يسبب Timeout
      await tester.pump(const Duration(milliseconds: 100));

      // Assert
      expect(find.byType(TrackOrderShimmer), findsOneWidget);
    });

    testWidgets('Should show error message when orderState has errorMessage', (tester) async {
      // Arrange
      const tError = "Connection Failed";
      final errorState = TrackOrderStatusState(
        orderState: BaseState(errorMessage: tError),
      );

      when(mockViewModel.state).thenReturn(errorState);
      when(mockViewModel.stream).thenAnswer((_) => Stream.value(errorState));

      // Act
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      // Assert
      expect(find.text(tError), findsOneWidget);
    });

// ... (البداية كما هي في الملف السابق)

    testWidgets('Should display Order Details correctly on Success state', (tester) async {
      // Arrange
      final tOrder = OrderTrackingEntity(
        status: 'delivered',
        driver: DriverEntity(
          name: 'Ali', // التأكد من أن الاسم هنا هو Ali
          vehicleImage: '',
          id: '',
          phone: '',
          token: '',
          vehicleNumber: '',
        ),
        id: 'order_123',
        orderNumber: '#123',
        updatedAt: DateTime.now(),
        totalPrice: 11,
        paymentType: 'Cash',
        shippingAddress: 'Cairo',
        trackingLocation: TrackingLocationEntity(lat: 5.0, long: 10.5),
        userLocationEntity: UserLocationEntity(lat: 6.5, long: 11.0),
      );

      final successState = TrackOrderStatusState(
        orderState: BaseState(data: tOrder),
        statusHistory: {"on_the_way": DateTime.now()},
      );

      when(mockViewModel.state).thenReturn(successState);
      when(mockViewModel.stream).thenAnswer((_) => Stream.value(successState));

      await mockNetworkImagesFor(() async {
        // Act
        await tester.pumpWidget(createWidgetUnderTest());


        // استخدام pump مرتين لضمان معالجة الحالة وبناء الـ Widgets
        await tester.pump();
        await tester.pump(const Duration(seconds: 1));

        // Assert
        expect(find.byType(DriverInfo), findsOneWidget);

        // التحقق من الاسم الصحيح الذي وضعناه في الـ Arrange (Ali وليس Ahmed Captain)
        expect(find.text("Ali"), findsOneWidget);

        expect(find.byIcon(Icons.call_outlined), findsOneWidget);
        expect(find.byWidgetPredicate((w) => w is FaIcon && w.icon == FontAwesomeIcons.whatsapp), findsOneWidget);
      });
    });

// ... (بقية الملف كما هي)
    group('DriverInfo standalone test', () {
      testWidgets('should display driver name and contact icons', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: const Scaffold(
              body: DriverInfo(name: "Ahmed"),
            ),
          ),
        );

        expect(find.text("Ahmed"), findsOneWidget);
        expect(find.byIcon(Icons.call_outlined), findsOneWidget);
        expect(find.byWidgetPredicate((w) => w is FaIcon && w.icon == FontAwesomeIcons.whatsapp), findsOneWidget);
      });
    });
  });
}