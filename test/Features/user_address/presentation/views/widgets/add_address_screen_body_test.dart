import 'package:bloc_test/bloc_test.dart';
import 'package:flowers_app/Features/user_address/data/models/add_address_request.dart';
import 'package:flowers_app/Features/user_address/data/models/edit_address_request/edit_address_request.dart';
import 'package:flowers_app/Features/user_address/domain/entities/address_entity.dart';
import 'package:flowers_app/Features/user_address/presentation/view_model/user_address_event.dart';
import 'package:flowers_app/Features/user_address/presentation/view_model/user_address_state.dart';
import 'package:flowers_app/Features/user_address/presentation/view_model/user_address_view_model.dart';
import 'package:flowers_app/Features/user_address/presentation/views/widgets/add_address_screen_body.dart';
import 'package:flowers_app/core/base_states/base_states.dart';
import 'package:flowers_app/core/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockUserAddressViewModel extends MockBloc<UserAddressEvent, UserAddressState>
    implements UserAddressViewModel {}

void main() {
  late MockUserAddressViewModel mockVM;

  setUpAll(() {
    registerFallbackValue(
      AddAddressEvent(
        AddAddressRequest(
          street: '', phone: '', username: '',
          city: '', lat: '', long: '',
        ),
      ),
    );

    registerFallbackValue(
      EditAddressEvent(
        EditAddressRequest(
          street: '', phone: '', username: '',
          city: '', lat: '', long: '',
        ),
        'fake_id_123',
      ),
    );
  });

  setUp(() {
    mockVM = MockUserAddressViewModel();
    // Default state
    when(() => mockVM.state).thenReturn(UserAddressState());
  });

  Widget createWidgetUnderTest({AddressEntity? addressToEdit}) {
    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en'), Locale('ar')],
      home: BlocProvider<UserAddressViewModel>.value(
        value: mockVM,
        child: Scaffold(
          body: AddAddressScreenBody(addressToEdit: addressToEdit),
        ),
      ),
    );
  }

  group('AddAddressScreenBody Widget Tests', () {
    testWidgets('should show loading indicator initially during GMS check', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}