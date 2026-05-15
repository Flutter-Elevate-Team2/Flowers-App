import 'dart:async';
import 'package:flowers_app/Features/user_address/domain/entities/address_entity.dart';
import 'package:flowers_app/Features/user_address/domain/entities/address_response_entity.dart';
import 'package:flowers_app/Features/user_address/presentation/view_model/user_address_event.dart';
import 'package:flowers_app/Features/user_address/presentation/view_model/user_address_state.dart';
import 'package:flowers_app/Features/user_address/presentation/view_model/user_address_view_model.dart';
import 'package:flowers_app/Features/user_address/presentation/views/screens/saved_address_screen.dart';
import 'package:flowers_app/Features/user_address/presentation/views/widgets/address_card.dart';
import 'package:flowers_app/core/base_states/base_states.dart';
import 'package:flowers_app/core/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([UserAddressViewModel])
import 'saved_address_screen_test.mocks.dart';

void main() {
  late MockUserAddressViewModel mockViewModel;
  late StreamController<UserAddressState> stateController;

  setUp(() {
    mockViewModel = MockUserAddressViewModel();
    stateController = StreamController<UserAddressState>.broadcast();

     when(mockViewModel.state).thenReturn(UserAddressState());
    when(mockViewModel.stream).thenAnswer((_) => stateController.stream);

     when(mockViewModel.doIntent(any)).thenReturn(null);
  });

  tearDown(() {
    stateController.close();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('en'),
       home: BlocProvider<UserAddressViewModel>.value(
        value: mockViewModel,
        child: const SavedAddressScreen(),
      ),
    );
  }

  group('SavedAddressScreen Widget Tests', () {
    testWidgets('Should call GetAddressesEvent on initState', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

       verify(mockViewModel.doIntent(argThat(isA<GetAddressesEvent>()))).called(1);
    });

    testWidgets('Should show CircularProgressIndicator when loading', (tester) async {
      when(mockViewModel.state).thenReturn(UserAddressState(
        getAddressesState: BaseState(isLoading: true),
      ));

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('Should show list of addresses when data is loaded successfully', (tester) async {
      final addresses = [
        AddressEntity(id: '1', street: 'Street 1', city: 'Cairo', phone: '', lat: '', long: '', username: ''),
        AddressEntity(id: '2', street: 'Street 2', city: 'Giza', phone: '', lat: '', long: '', username: ''),
      ];

      when(mockViewModel.state).thenReturn(UserAddressState(
        getAddressesState: BaseState(
          isLoading: false,
          data: AddressResponseEntity(addresses: addresses, message: 'Success'),
        ),
      ));

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(AddressCard), findsNWidgets(2));
      expect(find.text('Street 1'), findsOneWidget);
      expect(find.text('Street 2'), findsOneWidget);
    });

     testWidgets('Should show success SnackBar when an address is deleted', (tester) async {
      final address = AddressEntity(id: '1', street: 'Street 1', city: 'Cairo', phone: '', lat: '', long: '', username: '');

       final initialState = UserAddressState(
        getAddressesState: BaseState(
          isLoading: false,
          data: AddressResponseEntity(addresses: [address], message: ''),
        ),
      );

      when(mockViewModel.state).thenReturn(initialState);
      await tester.pumpWidget(createWidgetUnderTest());

       final successState = initialState.copyWith(
        deleteAddressState: BaseState(
          isLoading: false,
          data: AddressResponseEntity(addresses: [], message: 'Deleted'),
        ),
      );

      stateController.add(successState);

       await tester.pumpAndSettle();

      expect(find.byType(SnackBar), findsOneWidget);
    });
  });
}