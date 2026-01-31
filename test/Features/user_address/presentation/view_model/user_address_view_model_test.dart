import 'dart:async';

import 'package:flowers_app/Features/user_address/data/models/add_address_request.dart';
import 'package:flowers_app/Features/user_address/data/models/edit_address_request/edit_address_request.dart';
import 'package:flowers_app/Features/user_address/domain/entities/address_entity.dart';
import 'package:flowers_app/Features/user_address/domain/entities/address_response_entity.dart';
import 'package:flowers_app/Features/user_address/domain/use_case/add_address_use_case.dart';
import 'package:flowers_app/Features/user_address/domain/use_case/get_addresses_use_case.dart';
import 'package:flowers_app/Features/user_address/domain/use_case/user_address_use_case.dart';
import 'package:flowers_app/Features/user_address/presentation/view_model/user_address_event.dart';
import 'package:flowers_app/Features/user_address/presentation/view_model/user_address_state.dart';
import 'package:flowers_app/Features/user_address/presentation/view_model/user_address_view_model.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flowers_app/core/controller/session_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'user_address_view_model_test.mocks.dart';

@GenerateMocks([
  GetAddressesUseCase,
  AddAddressUseCase,
  UserAddressUseCase,
  SessionController,
])
void main() {
  late UserAddressViewModel viewModel;
  late MockGetAddressesUseCase mockGetAddressesUseCase;
  late MockAddAddressUseCase mockAddAddressUseCase;
  late MockUserAddressUseCase mockUserAddressUseCase;
  late MockSessionController mockSessionController;
  late StreamController<SessionEndReason> logoutStreamController;

  final tAddressEntity = AddressEntity(
    id: '1',
    street: '123 Main St',
    phone: '+201234567890',
    city: 'Cairo',
    lat: '30.0444',
    long: '31.2357',
    username: 'John Doe',
  );

  final tAddressResponseEntity = AddressResponseEntity(
    message: 'Success',
    addresses: [tAddressEntity],
  );

  setUp(() {
    provideDummy<BaseResponse<AddressResponseEntity>>(
      SuccessResponse(data: tAddressResponseEntity),
    );

    mockGetAddressesUseCase = MockGetAddressesUseCase();
    mockAddAddressUseCase = MockAddAddressUseCase();
    mockUserAddressUseCase = MockUserAddressUseCase();
    mockSessionController = MockSessionController();

    logoutStreamController = StreamController<SessionEndReason>.broadcast();
    final loginStreamController = StreamController<void>.broadcast();

    when(
      mockSessionController.onLogout,
    ).thenAnswer((_) => logoutStreamController.stream);

    when(
      mockSessionController.onLogin,
    ).thenAnswer((_) => loginStreamController.stream);

    viewModel = UserAddressViewModel(
      mockGetAddressesUseCase,
      mockAddAddressUseCase,
      mockUserAddressUseCase,
      mockSessionController,
    );

    // Ensure stream controllers are closed via addTearDown or in tearDown
    addTearDown(() {
      loginStreamController.close();
    });
  });

  tearDown(() {
    viewModel.close();
    logoutStreamController.close();
  });

  group('UserAddressViewModel - GetAddresses', () {
    test(
      'GetAddresses emits [Loading, Success] when usecase succeeds',
      () async {
        // Arrange
        when(mockGetAddressesUseCase.call()).thenAnswer(
          (_) async => SuccessResponse(data: tAddressResponseEntity),
        );

        // Assert
        expectLater(
          viewModel.stream,
          emitsInOrder([
            predicate<UserAddressState>(
              (s) => s.getAddressesState?.isLoading == true,
            ),
            predicate<UserAddressState>(
              (s) =>
                  s.getAddressesState?.isLoading == false &&
                  s.getAddressesState?.data == tAddressResponseEntity,
            ),
          ]),
        );

        // Act
        viewModel.doIntent(GetAddressesEvent());
      },
    );

    test('GetAddresses emits [Loading, Error] when usecase fails', () async {
      // Arrange
      const errorMessage = 'Failed to get addresses';
      when(mockGetAddressesUseCase.call()).thenAnswer(
        (_) async =>
            ErrorResponse<AddressResponseEntity>(errorMessage: errorMessage),
      );

      // Assert
      expectLater(
        viewModel.stream,
        emitsInOrder([
          predicate<UserAddressState>(
            (s) => s.getAddressesState?.isLoading == true,
          ),
          predicate<UserAddressState>(
            (s) =>
                s.getAddressesState?.isLoading == false &&
                s.getAddressesState?.errorMessage == errorMessage,
          ),
        ]),
      );

      // Act
      viewModel.doIntent(GetAddressesEvent());
    });
  });

  group('UserAddressViewModel - AddAddress', () {
    test('AddAddress emits [Loading, Success] when usecase succeeds', () async {
      // Arrange
      final request = AddAddressRequest(
        street: '123 Main St',
        phone: '+201234567890',
        city: 'Cairo',
        lat: '30.0444',
        long: '31.2357',
        username: 'John Doe',
      );

      when(
        mockAddAddressUseCase.call(any),
      ).thenAnswer((_) async => SuccessResponse(data: tAddressResponseEntity));

      when(
        mockGetAddressesUseCase.call(),
      ).thenAnswer((_) async => SuccessResponse(data: tAddressResponseEntity));

      // Assert
      expectLater(
        viewModel.stream,
        emitsInOrder([
          // Add Loading
          predicate<UserAddressState>(
            (s) => s.addAddressState?.isLoading == true,
          ),
          // Add Success
          predicate<UserAddressState>(
            (s) =>
                s.addAddressState?.isLoading == false &&
                s.addAddressState?.data == tAddressResponseEntity,
          ),
          // Get Loading (triggered automatically)
          predicate<UserAddressState>(
            (s) => s.getAddressesState?.isLoading == true,
          ),
          // Get Success
          predicate<UserAddressState>(
            (s) => s.getAddressesState?.isLoading == false,
          ),
        ]),
      );

      // Act
      viewModel.doIntent(AddAddressEvent(request));
    });

    test('AddAddress emits [Loading, Error] when usecase fails', () async {
      // Arrange
      final request = AddAddressRequest(
        street: '123 Main St',
        phone: '+201234567890',
        city: 'Cairo',
        lat: '30.0444',
        long: '31.2357',
        username: 'John Doe',
      );

      const errorMessage = 'Failed to add address';
      when(mockAddAddressUseCase.call(any)).thenAnswer(
        (_) async =>
            ErrorResponse<AddressResponseEntity>(errorMessage: errorMessage),
      );

      // Assert
      expectLater(
        viewModel.stream,
        emitsInOrder([
          predicate<UserAddressState>(
            (s) => s.addAddressState?.isLoading == true,
          ),
          predicate<UserAddressState>(
            (s) =>
                s.addAddressState?.isLoading == false &&
                s.addAddressState?.errorMessage == errorMessage,
          ),
        ]),
      );

      // Act
      viewModel.doIntent(AddAddressEvent(request));
    });
  });

  group('UserAddressViewModel - EditAddress', () {
    test(
      'EditAddress emits [Loading, Success] when usecase succeeds',
      () async {
        // Arrange
        final request = EditAddressRequest(
          street: 'Updated Street',
          phone: '+201234567890',
          city: 'Cairo',
          lat: '30.0444',
          long: '31.2357',
          username: 'John Doe',
        );
        const addressId = '1';

        when(mockUserAddressUseCase.editAddress(any, any)).thenAnswer(
          (_) async => SuccessResponse(data: tAddressResponseEntity),
        );

        // Mock GetAddresses as it is called after Edit
        when(mockGetAddressesUseCase.call()).thenAnswer(
          (_) async => SuccessResponse(data: tAddressResponseEntity),
        );

        // Assert
        expectLater(
          viewModel.stream,
          emitsInOrder([
            // Edit Loading
            predicate<UserAddressState>(
              (s) => s.editAddressState?.isLoading == true,
            ),
            // Edit Success
            predicate<UserAddressState>(
              (s) =>
                  s.editAddressState?.isLoading == false &&
                  s.editAddressState?.data == tAddressResponseEntity,
            ),
            // Get Loading
            predicate<UserAddressState>(
              (s) => s.getAddressesState?.isLoading == true,
            ),
            // Get Success
            predicate<UserAddressState>(
              (s) => s.getAddressesState?.isLoading == false,
            ),
          ]),
        );

        // Act
        viewModel.doIntent(EditAddressEvent(request, addressId));
      },
    );

    test('EditAddress emits [Loading, Error] when usecase fails', () async {
      // Arrange
      final request = EditAddressRequest(
        street: 'Updated Street',
        phone: '+201234567890',
        city: 'Cairo',
        lat: '30.0444',
        long: '31.2357',
        username: 'John Doe',
      );
      const addressId = '1';

      const errorMessage = 'Failed to edit address';
      when(mockUserAddressUseCase.editAddress(any, any)).thenAnswer(
        (_) async =>
            ErrorResponse<AddressResponseEntity>(errorMessage: errorMessage),
      );

      // Assert
      expectLater(
        viewModel.stream,
        emitsInOrder([
          predicate<UserAddressState>(
            (s) => s.editAddressState?.isLoading == true,
          ),
          predicate<UserAddressState>(
            (s) =>
                s.editAddressState?.isLoading == false &&
                s.editAddressState?.errorMessage == errorMessage,
          ),
        ]),
      );

      // Act
      viewModel.doIntent(EditAddressEvent(request, addressId));
    });
  });

  group('UserAddressViewModel - DeleteAddress', () {
    test(
      'DeleteAddress emits [Loading, Success] and refreshes addresses when usecase succeeds',
      () async {
        // Arrange
        const addressId = '1';

        when(mockUserAddressUseCase.deleteAddress(any)).thenAnswer(
          (_) async => SuccessResponse(data: tAddressResponseEntity),
        );

        when(mockGetAddressesUseCase.call()).thenAnswer(
          (_) async => SuccessResponse(data: tAddressResponseEntity),
        );

        final expectedStates = [
          predicate<UserAddressState>(
            (s) => s.deleteAddressState?.isLoading == true,
          ),
          predicate<UserAddressState>(
            (s) =>
                s.deleteAddressState?.isLoading == false &&
                s.deleteAddressState?.data == tAddressResponseEntity,
          ),
          predicate<UserAddressState>(
            (s) => s.getAddressesState?.isLoading == true,
          ),
          predicate<UserAddressState>(
            (s) =>
                s.getAddressesState?.isLoading == false &&
                s.getAddressesState?.data == tAddressResponseEntity,
          ),
        ];

        // Assert
        expectLater(viewModel.stream, emitsInOrder(expectedStates));

        // Act
        viewModel.doIntent(DeleteAddressEvent(addressId));
      },
    );

    test('DeleteAddress emits [Loading, Error] when usecase fails', () async {
      // Arrange
      const addressId = '1';
      const errorMessage = 'Failed to delete address';

      when(mockUserAddressUseCase.deleteAddress(any)).thenAnswer(
        (_) async =>
            ErrorResponse<AddressResponseEntity>(errorMessage: errorMessage),
      );

      // Assert
      expectLater(
        viewModel.stream,
        emitsInOrder([
          predicate<UserAddressState>(
            (s) => s.deleteAddressState?.isLoading == true,
          ),
          predicate<UserAddressState>(
            (s) =>
                s.deleteAddressState?.isLoading == false &&
                s.deleteAddressState?.errorMessage == errorMessage,
          ),
        ]),
      );

      // Act
      viewModel.doIntent(DeleteAddressEvent(addressId));
    });
  });

  group('UserAddressViewModel - Logout Handling', () {
    test(
      'Should emit empty UserAddressState when logout event occurs',
      () async {
        // Act
        logoutStreamController.add(SessionEndReason.logout);

        // Assert
        expectLater(
          viewModel.stream,
          emits(
            predicate<UserAddressState>(
              (s) =>
                  s.getAddressesState == null &&
                  s.addAddressState == null &&
                  s.editAddressState == null &&
                  s.deleteAddressState == null,
            ),
          ),
        );
      },
    );
  });

  group('UserAddressViewModel - ResetDeleteState', () {
    test('resetDeleteState should reset delete state', () async {
      // Assert
      expectLater(
        viewModel.stream,
        emits(
          predicate<UserAddressState>(
            (s) => s.deleteAddressState?.isLoading == false,
          ),
        ),
      );

      // Act
      viewModel.resetDeleteState();
    });
  });
}
