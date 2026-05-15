import 'package:flowers_app/Features/commerce/presentation/home/widgets/shared/address_selection_bottom_sheet.dart';
import 'package:flowers_app/Features/user_address/domain/entities/address_entity.dart';
import 'package:flowers_app/core/app_router/app_router.dart';
import 'package:flowers_app/core/l10n/app_localizations.dart';
import 'package:flowers_app/core/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

void main() {
  late List<AddressEntity> testAddresses;

  setUp(() {
    testAddresses = [
      AddressEntity(
        id: '1',
        username: 'Ahmed',
        street: 'Street 1',
        city: 'Cairo',
        phone: '123',
        lat: '',
        long: '',
      ),
      AddressEntity(
        id: '2',
        username: 'Sara',
        street: 'Street 2',
        city: 'Giza',
        phone: '456',
        lat: '',
        long: '',
      ),
    ];
  });

  Widget createWidgetUnderTest({
    List<AddressEntity>? addresses,
    AddressEntity? selectedAddress,
    Function(AddressEntity)? onAddressSelected,
  }) {
    final router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => Scaffold(
            body: Builder(
              builder: (innerContext) => Center(
                child: ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: innerContext,
                      builder: (_) => AddressSelectionBottomSheet(
                        addresses: addresses ?? testAddresses,
                        selectedAddress: selectedAddress,
                        onAddressSelected: onAddressSelected ?? (_) {},
                      ),
                    );
                  },
                  child: const Text('Open Sheet'),
                ),
              ),
            ),
          ),
        ),
        GoRoute(
          path: '/add-address',
          name: Routes.addAddressName,
          builder: (context, state) =>
              const Scaffold(body: Text('Add Address Page')),
        ),
      ],
    );

    return MaterialApp.router(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: router,
    );
  }

  Future<void> openSheet(WidgetTester tester) async {
    await tester.tap(find.text('Open Sheet'));
    await tester.pumpAndSettle();
  }

  group('AddressSelectionBottomSheet Tests', () {
    testWidgets('renders list of addresses correctly', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await openSheet(tester);

      expect(find.text('Ahmed'), findsOneWidget);
      expect(find.text('Sara'), findsOneWidget);
      expect(find.byType(ListTile), findsNWidgets(2));
    });

    testWidgets('shows empty state when no addresses provided', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest(addresses: []));
      await openSheet(tester);

      expect(find.byType(CustomButton), findsOneWidget);
    });

    testWidgets(
      'calls onAddressSelected and closes when an address is tapped',
      (tester) async {
        AddressEntity? selected;
        await tester.pumpWidget(
          createWidgetUnderTest(onAddressSelected: (addr) => selected = addr),
        );
        await openSheet(tester);

        await tester.tap(find.text('Sara'));
        await tester.pumpAndSettle();

        expect(selected?.id, '2');
        expect(find.text('Open Sheet'), findsOneWidget);
      },
    );

    testWidgets('navigates to Add Address screen when button is pressed', (
      tester,
    ) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await openSheet(tester);

      final addNewBtn = find.byType(CustomButton);
      await tester.tap(addNewBtn);

      await tester.pumpAndSettle();

      expect(find.text('Add Address Page'), findsOneWidget);
    });

    group('Visual Selection Test', () {
      testWidgets('highlights the selected address', (tester) async {
        await tester.pumpWidget(
          createWidgetUnderTest(selectedAddress: testAddresses[0]),
        );
        await openSheet(tester);

        expect(find.byIcon(Icons.check_circle), findsOneWidget);
      });
    });
  });
}
