import 'dart:async';

import 'package:flowers_app/Features/user_address/domain/entities/address_entity.dart';
import 'package:flowers_app/Features/user_address/domain/entities/address_response_entity.dart';
import 'package:flowers_app/Features/user_address/presentation/view_model/user_address_state.dart';
import 'package:flowers_app/Features/user_address/presentation/view_model/user_address_view_model.dart';
import 'package:flowers_app/Features/user_address/presentation/views/widgets/add_address_screen_body.dart';
import 'package:flowers_app/core/base_states/base_states.dart';
import 'package:flowers_app/core/l10n/app_localizations.dart';
import 'package:flowers_app/core/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:mockito/mockito.dart';

import '../screens/saved_address_screen_test.mocks.dart';

void main() {
  late MockUserAddressViewModel mockViewModel;

  setUpAll(() {
    final getIt = GetIt.instance;
    getIt.reset();

    // Mock Google Play Services Check
    const MethodChannel(
      'flutter.baseflow.com/google_api_availability/methods',
    ).setMockMethodCallHandler((MethodCall methodCall) async {
      if (methodCall.method == 'checkGooglePlayServicesAvailability') {
        return 0; // success
      }
      return null;
    });
  });

  setUp(() {
    mockViewModel = MockUserAddressViewModel();
    final getIt = GetIt.instance;
    getIt.allowReassignment = true;

    if (!getIt.isRegistered<UserAddressViewModel>()) {
      getIt.registerFactory<UserAddressViewModel>(() => mockViewModel);
    } else {
      getIt.unregister<UserAddressViewModel>();
      getIt.registerFactory<UserAddressViewModel>(() => mockViewModel);
    }

    when(mockViewModel.close()).thenAnswer((_) async {
      return;
    });
  });

  tearDown(() {
    final getIt = GetIt.instance;
    getIt.reset();
  });

  Widget buildTestableWidget({AddressEntity? addressToEdit}) {
    final router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => Scaffold(
            body: AddAddressScreenBody(addressToEdit: addressToEdit),
          ),
        ),
      ],
    );

    return MaterialApp.router(
      routerConfig: router,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en'), Locale('ar')],
    );
  }

  testWidgets('Shows CircularProgressIndicator during GMS check ..... ', (
    WidgetTester tester,
  ) async {
    // Arrange
    when(mockViewModel.state).thenReturn(UserAddressState());
    when(
      mockViewModel.stream,
    ).thenAnswer((_) => Stream<UserAddressState>.value(UserAddressState()));

    // Act
    await tester.pumpWidget(buildTestableWidget());

    // Assert
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Add Address Loading State ..... ', (WidgetTester tester) async {
    // Arrange
    when(mockViewModel.state).thenReturn(
      UserAddressState(
        addAddressState: BaseState<AddressResponseEntity>(isLoading: true),
      ),
    );
    when(mockViewModel.stream).thenAnswer(
      (_) => Stream<UserAddressState>.value(
        UserAddressState(
          addAddressState: BaseState<AddressResponseEntity>(isLoading: true),
        ),
      ),
    );

    // Act
    await tester.pumpWidget(buildTestableWidget());
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    // Assert
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.byType(CustomButton), findsNothing);
  });

  testWidgets('Add Address Success State ..... ', (WidgetTester tester) async {
    // Arrange
    final controller = StreamController<UserAddressState>.broadcast();
    final mockAddressResponse = AddressResponseEntity(
      addresses: [],
      message: 'Address added successfully',
    );

    when(mockViewModel.state).thenReturn(UserAddressState());
    when(mockViewModel.stream).thenAnswer((_) => controller.stream);

    // Act
    await tester.pumpWidget(buildTestableWidget());

    // Trigger Success
    controller.add(
      UserAddressState(
        addAddressState: BaseState<AddressResponseEntity>(
          isLoading: false,
          data: mockAddressResponse,
        ),
      ),
    );

    try {
      await tester.pumpAndSettle();
    } catch (e) {
      if (!e.toString().contains('nothing to pop') &&
          !e.toString().contains('GoError')) {
        rethrow;
      }
    }

    await controller.close();
  });

  testWidgets('Add Address Error State ..... ', (WidgetTester tester) async {
    // Arrange
    const String mockErrorMsg = 'Failed to add address';
    final controller = StreamController<UserAddressState>.broadcast();

    // نبدأ بحالة نظيفة
    when(mockViewModel.state).thenReturn(UserAddressState());
    when(mockViewModel.stream).thenAnswer((_) => controller.stream);

    // Act
    await tester.pumpWidget(buildTestableWidget());
    await tester.pump(); // Build initial UI

    // نرسل حالة الخطأ
    controller.add(
      UserAddressState(
        addAddressState: BaseState<AddressResponseEntity>(
          isLoading: false,
          errorMessage: mockErrorMsg,
        ),
      ),
    );

    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    // Assert
    expect(find.text(mockErrorMsg), findsOneWidget);

    await controller.close();
  });

  testWidgets('Edit Address Loading State ..... ', (WidgetTester tester) async {
    // Arrange
    const mockAddress = AddressEntity(
      id: '1',
      street: '123 Test Street',
      phone: '+201234567890',
      city: 'Cairo',
      lat: '30.0444',
      long: '31.2357',
      username: 'John Doe',
    );

    when(mockViewModel.state).thenReturn(
      UserAddressState(
        editAddressState: BaseState<AddressResponseEntity>(isLoading: true),
      ),
    );
    when(mockViewModel.stream).thenAnswer(
      (_) => Stream<UserAddressState>.value(
        UserAddressState(
          editAddressState: BaseState<AddressResponseEntity>(isLoading: true),
        ),
      ),
    );

    // Act
    await tester.pumpWidget(buildTestableWidget(addressToEdit: mockAddress));
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    // Assert
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Edit Address Error State ..... ', (WidgetTester tester) async {
    // Arrange
    const mockAddress = AddressEntity(
      id: '1',
      street: '123 Test Street',
      phone: '+201234567890',
      city: 'Cairo',
      lat: '30.0444',
      long: '31.2357',
      username: 'John Doe',
    );
    const String mockErrorMsg = 'Failed to update address';
    final controller = StreamController<UserAddressState>.broadcast();

    when(mockViewModel.state).thenReturn(UserAddressState());
    when(mockViewModel.stream).thenAnswer((_) => controller.stream);

    // Act
    await tester.pumpWidget(buildTestableWidget(addressToEdit: mockAddress));
    await tester.pump();

    controller.add(
      UserAddressState(
        editAddressState: BaseState<AddressResponseEntity>(
          isLoading: false,
          errorMessage: mockErrorMsg,
        ),
      ),
    );

    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    // Assert
    expect(find.text(mockErrorMsg), findsOneWidget);

    await controller.close();
  });

  testWidgets('Form fields are rendered ..... ', (WidgetTester tester) async {
    // Arrange
    when(mockViewModel.state).thenReturn(UserAddressState());
    when(
      mockViewModel.stream,
    ).thenAnswer((_) => Stream<UserAddressState>.value(UserAddressState()));

    // Act
    await tester.pumpWidget(buildTestableWidget());
    await tester.pumpAndSettle(const Duration(seconds: 2));

    // Assert
    expect(
      find.byType(TextFormField),
      findsNWidgets(3),
    ); // address, phone, name
    expect(
      find.byWidgetPredicate((widget) => widget is DropdownButtonFormField),
      findsAtLeastNWidgets(2),
    ); // city, area
  });
}
