import 'package:flowers_app/Features/user_address/domain/entities/address_entity.dart';
import 'package:flowers_app/Features/user_address/presentation/views/widgets/address_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AddressEntity mockAddress;
  bool deleteCallbackCalled = false;
  bool editCallbackCalled = false;

  setUp(() {
    mockAddress = const AddressEntity(
      id: '1',
      street: '123 Test Street, Apartment 4',
      phone: '+201234567890',
      city: 'Cairo',
      lat: '30.0444',
      long: '31.2357',
      username: 'John Doe',
    );
    deleteCallbackCalled = false;
    editCallbackCalled = false;
  });

  Widget buildTestableWidget({VoidCallback? onDelete, VoidCallback? onEdit}) {
    return MaterialApp(
      home: Scaffold(
        body: AddressCard(
          address: mockAddress,
          onDelete: onDelete,
          onEdit: onEdit,
        ),
      ),
    );
  }

  testWidgets('Renders address information correctly ..... ', (
    WidgetTester tester,
  ) async {
    // Arrange & Act
    await tester.pumpWidget(buildTestableWidget());

    // Assert
    expect(find.text('Cairo'), findsOneWidget);
    expect(find.text('123 Test Street, Apartment 4'), findsOneWidget);
    expect(find.byIcon(Icons.location_on_outlined), findsOneWidget);
  });

  testWidgets('Delete icon button is present and triggers callback ..... ', (
    WidgetTester tester,
  ) async {
    // Arrange
    await tester.pumpWidget(
      buildTestableWidget(onDelete: () => deleteCallbackCalled = true),
    );

    // Act
    final deleteButton = find.byIcon(Icons.delete_outline);
    expect(deleteButton, findsOneWidget);
    await tester.tap(deleteButton);
    await tester.pump();

    // Assert
    expect(deleteCallbackCalled, true);
  });

  testWidgets('Edit icon button is present and triggers callback ..... ', (
    WidgetTester tester,
  ) async {
    // Arrange
    await tester.pumpWidget(
      buildTestableWidget(onEdit: () => editCallbackCalled = true),
    );

    // Act
    final editButton = find.byIcon(Icons.edit_outlined);
    expect(editButton, findsOneWidget);
    await tester.tap(editButton);
    await tester.pump();

    // Assert
    expect(editCallbackCalled, true);
  });

  testWidgets('All UI elements are present ..... ', (
    WidgetTester tester,
  ) async {
    // Arrange & Act
    await tester.pumpWidget(buildTestableWidget());

    // Assert
    expect(find.byType(Container), findsWidgets);
    expect(find.byIcon(Icons.location_on_outlined), findsOneWidget);
    expect(find.byIcon(Icons.delete_outline), findsOneWidget);
    expect(find.byIcon(Icons.edit_outlined), findsOneWidget);
    expect(find.byType(InkWell), findsNWidgets(2));
  });

  testWidgets('Card displays when onDelete and onEdit are null ..... ', (
    WidgetTester tester,
  ) async {
    // Arrange & Act
    await tester.pumpWidget(buildTestableWidget(onDelete: null, onEdit: null));

    // Assert
    expect(find.text('Cairo'), findsOneWidget);
    expect(find.text('123 Test Street, Apartment 4'), findsOneWidget);
    expect(find.byIcon(Icons.delete_outline), findsOneWidget);
    expect(find.byIcon(Icons.edit_outlined), findsOneWidget);
  });
}
