import 'package:flowers_app/Features/user_address/domain/entities/address_entity.dart';
import 'package:flowers_app/Features/user_address/presentation/view_model/user_address_state.dart';
import 'package:flowers_app/Features/user_address/presentation/view_model/user_address_view_model.dart';
import 'package:flowers_app/Features/user_address/presentation/views/screens/add_address_screen.dart';
import 'package:flowers_app/Features/user_address/presentation/views/widgets/add_address_screen_body.dart';
import 'package:flowers_app/core/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';

import 'saved_address_screen_test.mocks.dart';

void main() {
  late MockUserAddressViewModel mockViewModel;

  setUp(() async {
    mockViewModel = MockUserAddressViewModel();
    final getIt = GetIt.instance;

    await getIt.reset();

    getIt.registerFactory<UserAddressViewModel>(() => mockViewModel);

    when(mockViewModel.close()).thenAnswer((_) async {});
    when(mockViewModel.state).thenReturn(UserAddressState());
    when(
      mockViewModel.stream,
    ).thenAnswer((_) => Stream.value(UserAddressState()));
  });

  tearDown(() async {
    await GetIt.instance.reset();
  });

  Widget buildTestableWidget({AddressEntity? addressToEdit}) {
    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en'), Locale('ar')],
      home: AddAddressScreen(addressToEdit: addressToEdit),
    );
  }

  testWidgets('Add mode - AppBar shows Add New Address title ..... ', (
    WidgetTester tester,
  ) async {
    // Arrange & Act
    await tester.pumpWidget(buildTestableWidget());
    await tester.pump();

    // Assert
    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byType(AddAddressScreenBody), findsOneWidget);
    // Back button icon
    expect(find.byIcon(Icons.arrow_back_ios), findsOneWidget);
  });

  testWidgets('Edit mode - AppBar shows Update Address title ..... ', (
    WidgetTester tester,
  ) async {
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

    // Act
    await tester.pumpWidget(buildTestableWidget(addressToEdit: mockAddress));
    await tester.pump();

    // Assert
    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byType(AddAddressScreenBody), findsOneWidget);
  });

  testWidgets('Back button is present ..... ', (WidgetTester tester) async {
    // Arrange & Act
    await tester.pumpWidget(buildTestableWidget());
    await tester.pump();

    // Assert
    expect(find.byIcon(Icons.arrow_back_ios), findsOneWidget);
    expect(find.byType(IconButton), findsOneWidget);
  });

  testWidgets(
    'AddAddressScreenBody is rendered with null addressToEdit ..... ',
    (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(buildTestableWidget());
      await tester.pump();

      // Assert
      expect(find.byType(AddAddressScreenBody), findsOneWidget);
      final bodyWidget = tester.widget<AddAddressScreenBody>(
        find.byType(AddAddressScreenBody),
      );
      expect(bodyWidget.addressToEdit, isNull);
    },
  );

  testWidgets(
    'AddAddressScreenBody is rendered with addressToEdit in edit mode ..... ',
    (WidgetTester tester) async {
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

      // Act
      await tester.pumpWidget(buildTestableWidget(addressToEdit: mockAddress));
      await tester.pump();

      // Assert
      expect(find.byType(AddAddressScreenBody), findsOneWidget);
      final bodyWidget = tester.widget<AddAddressScreenBody>(
        find.byType(AddAddressScreenBody),
      );
      expect(bodyWidget.addressToEdit, mockAddress);
    },
  );
}
