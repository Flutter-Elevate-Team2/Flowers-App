import 'dart:async';

import 'package:flowers_app/Features/user_address/domain/entities/address_entity.dart';
import 'package:flowers_app/Features/user_address/domain/entities/address_response_entity.dart';
import 'package:flowers_app/Features/user_address/presentation/view_model/user_address_state.dart';
import 'package:flowers_app/Features/user_address/presentation/view_model/user_address_view_model.dart';
import 'package:flowers_app/Features/user_address/presentation/views/screens/saved_address_screen.dart';
import 'package:flowers_app/Features/user_address/presentation/views/widgets/add_address_button.dart';
import 'package:flowers_app/Features/user_address/presentation/views/widgets/address_card.dart';
import 'package:flowers_app/core/base_states/base_states.dart';
import 'package:flowers_app/core/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'saved_address_screen_test.mocks.dart';

@GenerateMocks([UserAddressViewModel])
void main() {
  late MockUserAddressViewModel mockViewModel;

  setUpAll(() async {
    final getIt = GetIt.instance;
    await getIt.reset();
  });

  setUp(() async {
    mockViewModel = MockUserAddressViewModel();
    final getIt = GetIt.instance;
    await getIt.reset();

    getIt.registerFactory<UserAddressViewModel>(() => mockViewModel);

    when(mockViewModel.close()).thenAnswer((_) async {
      return null;
    });
  });

  tearDown(() async {
    final getIt = GetIt.instance;
    await getIt.reset();
  });

  Widget buildTestableWidget() {
    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en'), Locale('ar')],
      home: const SavedAddressScreen(),
    );
  }

  testWidgets('Loading State ..... ', (WidgetTester tester) async {
    // Arrange
    final state = UserAddressState(
      getAddressesState: BaseState<AddressResponseEntity>(isLoading: true),
    );
    when(mockViewModel.state).thenReturn(state);

    final controller = StreamController<UserAddressState>.broadcast();
    when(mockViewModel.stream).thenAnswer((_) => controller.stream);
    controller.add(state);

    // Act
    await tester.pumpWidget(buildTestableWidget());
    await tester.pump();

    // Assert
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.byType(ListView), findsNothing);
    expect(find.byType(AddressCard), findsNothing);

    await controller.close();
  });

  testWidgets('Error State ..... ', (WidgetTester tester) async {
    // Arrange
    const String mockErrorMsg = 'Failed to load addresses';
    final state = UserAddressState(
      getAddressesState: BaseState<AddressResponseEntity>(
        isLoading: false,
        errorMessage: mockErrorMsg,
      ),
    );
    when(mockViewModel.state).thenReturn(state);

    final controller = StreamController<UserAddressState>.broadcast();
    when(mockViewModel.stream).thenAnswer((_) => controller.stream);
    controller.add(state);

    // Act
    await tester.pumpWidget(buildTestableWidget());
    await tester.pump();

    // Assert
    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.byType(ListView), findsNothing);

    expect(find.text(mockErrorMsg), findsOneWidget);

    expect(find.byType(Center), findsWidgets);

    await controller.close();
  });

  testWidgets('Empty State - No Saved Addresses ..... ', (
    WidgetTester tester,
  ) async {
    // Arrange
    final mockAddressResponse = AddressResponseEntity(
      addresses: [],
      message: 'Success',
    );
    when(mockViewModel.state).thenReturn(
      UserAddressState(
        getAddressesState: BaseState<AddressResponseEntity>(
          isLoading: false,
          data: mockAddressResponse,
        ),
      ),
    );
    when(mockViewModel.stream).thenAnswer(
      (_) => Stream<UserAddressState>.value(
        UserAddressState(
          getAddressesState: BaseState<AddressResponseEntity>(
            isLoading: false,
            data: mockAddressResponse,
          ),
        ),
      ),
    );

    // Act
    await tester.pumpWidget(buildTestableWidget());
    await tester.pump();

    // Assert
    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.byType(ListView), findsNothing);
    expect(find.byType(AddressCard), findsNothing);

    expect(find.byType(Center), findsWidgets);
  });

  testWidgets('Success State With 3 Addresses ..... ', (
    WidgetTester tester,
  ) async {
    // Arrange
    final List<AddressEntity> mockAddresses = [
      const AddressEntity(
        id: '1',
        street: 'Street 1',
        phone: '+201111111111',
        city: 'Cairo',
        lat: '30.0444',
        long: '31.2357',
        username: 'User 1',
      ),
      const AddressEntity(
        id: '2',
        street: 'Street 2',
        phone: '+202222222222',
        city: 'Alexandria',
        lat: '31.2001',
        long: '29.9187',
        username: 'User 2',
      ),
      const AddressEntity(
        id: '3',
        street: 'Street 3',
        phone: '+203333333333',
        city: 'Giza',
        lat: '30.0131',
        long: '31.2089',
        username: 'User 3',
      ),
    ];
    final mockAddressResponse = AddressResponseEntity(
      addresses: mockAddresses,
      message: 'Success',
    );
    when(mockViewModel.state).thenReturn(
      UserAddressState(
        getAddressesState: BaseState<AddressResponseEntity>(
          isLoading: false,
          data: mockAddressResponse,
        ),
      ),
    );
    when(mockViewModel.stream).thenAnswer(
      (_) => Stream<UserAddressState>.value(
        UserAddressState(
          getAddressesState: BaseState<AddressResponseEntity>(
            isLoading: false,
            data: mockAddressResponse,
          ),
        ),
      ),
    );

    // Act
    await tester.pumpWidget(buildTestableWidget());
    await tester.pump();

    // Assert
    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(AddressCard), findsNWidgets(3));
    expect(find.text('Cairo'), findsOneWidget);
    expect(find.text('Street 1'), findsOneWidget);
  });

  testWidgets('AddAddressButton is present ..... ', (
    WidgetTester tester,
  ) async {
    // Arrange
    final mockAddressResponse = AddressResponseEntity(
      addresses: [],
      message: 'Success',
    );
    when(mockViewModel.state).thenReturn(
      UserAddressState(
        getAddressesState: BaseState<AddressResponseEntity>(
          isLoading: false,
          data: mockAddressResponse,
        ),
      ),
    );
    when(mockViewModel.stream).thenAnswer(
      (_) => Stream<UserAddressState>.value(
        UserAddressState(
          getAddressesState: BaseState<AddressResponseEntity>(
            isLoading: false,
            data: mockAddressResponse,
          ),
        ),
      ),
    );

    // Act
    await tester.pumpWidget(buildTestableWidget());
    await tester.pump();

    // Assert
    expect(find.byType(AddAddressButton), findsOneWidget);
  });
}
