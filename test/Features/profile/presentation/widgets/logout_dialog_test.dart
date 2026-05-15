import 'dart:async';
import 'package:flowers_app/Features/profile/presentation/view_model/profile_state.dart';
import 'package:flowers_app/Features/profile/presentation/view_model/profile_view_model.dart';
import 'package:flowers_app/Features/profile/presentation/widgets/logout_dialog.dart';
import 'package:flowers_app/core/base_states/base_states.dart';
import 'package:flowers_app/core/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

 @GenerateMocks([ProfileViewModel])
import 'logout_dialog_test.mocks.dart';

void main() {
  late MockProfileViewModel mockViewModel;

  setUp(() {
    mockViewModel = MockProfileViewModel();
     when(mockViewModel.state).thenReturn(ProfileState());
    when(mockViewModel.stream).thenAnswer((_) => Stream.value(ProfileState()));
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('en'),
      home: Scaffold(
        body: BlocProvider<ProfileViewModel>.value(
          value: mockViewModel,
          child: const LogoutDialog(),
        ),
      ),
    );
  }

  testWidgets('Should call LogoutEvent when logout button is pressed', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest());


    final logoutButton = find.widgetWithText(ElevatedButton, 'Logout');
    await tester.tap(logoutButton);

     verify(mockViewModel.doIntent(any)).called(1);
  });

  testWidgets('Should show loading indicator when logoutState is loading', (tester) async {
    when(mockViewModel.state).thenReturn(ProfileState(
      logoutState: BaseState(isLoading: true),
    ));

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

     final logoutButton = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(logoutButton.onPressed, isNull);
  });

 }