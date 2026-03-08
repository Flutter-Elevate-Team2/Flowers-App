import 'package:bloc_test/bloc_test.dart';
import 'package:flowers_app/Features/commerce/presentation/home/widgets/shared/address_selection_bottom_sheet.dart';
import 'package:flowers_app/Features/user_address/domain/entities/address_entity.dart';
import 'package:flowers_app/Features/user_address/domain/entities/address_response_entity.dart';
import 'package:flowers_app/Features/user_address/presentation/view_model/user_address_state.dart';
import 'package:flowers_app/Features/user_address/presentation/view_model/user_address_view_model.dart';
import 'package:flowers_app/core/base_states/base_states.dart';
import 'package:flowers_app/core/l10n/app_localizations.dart';
import 'package:flowers_app/core/widget/address_selector.dart';
import 'package:flowers_app/core/widget/selected_address_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

 class MockUserAddressViewModel extends MockCubit<UserAddressState> implements UserAddressViewModel {}
class MockSelectedAddressCubit extends MockCubit<AddressEntity?> implements SelectedAddressCubit {}

void main() {
  late MockUserAddressViewModel mockViewModel;
  late MockSelectedAddressCubit mockCubit;

  setUp(() {
    mockViewModel = MockUserAddressViewModel();
    mockCubit = MockSelectedAddressCubit();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: MultiBlocProvider(
          providers: [
            BlocProvider<UserAddressViewModel>.value(value: mockViewModel),
            BlocProvider<SelectedAddressCubit>.value(value: mockCubit),
          ],
          child: const AddressSelector(),
        ),
      ),
    );
  }

  group('AddressSelector Interaction Tests', () {

    testWidgets('should NOT open BottomSheet and should navigate if addresses are empty', (tester) async {
      // Arrange: Empty addresses
      final emptyState = UserAddressState(
        getAddressesState: BaseState<AddressResponseEntity>(
          isLoading: false,
          data:   AddressResponseEntity(addresses: [], message: ''),
        ),
      );

      whenListen(mockViewModel, Stream.value(emptyState), initialState: emptyState);
      whenListen(mockCubit, Stream.value(null), initialState: null);

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      // Act
      await tester.tap(find.byType(GestureDetector));
      await tester.pumpAndSettle();

      // Assert: BottomSheet should NOT be present
      expect(find.byType(AddressSelectionBottomSheet), findsNothing);
    });
  });
 }