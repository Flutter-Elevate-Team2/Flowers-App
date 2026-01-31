import 'package:flowers_app/Features/order/presentation/cart/view_model/cart_states.dart';
import 'package:flowers_app/Features/order/presentation/cart/view_model/cart_view_model.dart';
import 'package:flowers_app/Features/order/presentation/check_out/view_model/checkout_states.dart';
import 'package:flowers_app/Features/order/presentation/check_out/view_model/checkout_view_model.dart';
import 'package:flowers_app/Features/order/presentation/check_out/widgets/check_out_body.dart';
import 'package:flowers_app/Features/order/presentation/check_out/widgets/payment_method_option.dart';
import 'package:flowers_app/Features/order/presentation/check_out/widgets/payment_method_section.dart';
import 'package:flowers_app/Features/user_address/presentation/view_model/user_address_state.dart';
import 'package:flowers_app/Features/user_address/presentation/view_model/user_address_view_model.dart';
import 'package:flowers_app/core/l10n/app_localizations.dart';
import 'package:flowers_app/core/l10n/view_model/language_cubit.dart';
import 'package:flowers_app/core/widget/selected_address_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'check_out_body_test.mocks.dart';

@GenerateMocks([
  CheckoutViewModel,
  CartViewModel,
  LanguageCubit,
  SelectedAddressCubit,
  UserAddressViewModel,
])
void main() {
  late MockCheckoutViewModel checkoutCubit;
  late MockCartViewModel cartCubit;
  late MockLanguageCubit languageCubit;
  late MockSelectedAddressCubit selectedAddressCubit;
  late MockUserAddressViewModel userAddressViewModel;

  setUp(() {
    checkoutCubit = MockCheckoutViewModel();
    cartCubit = MockCartViewModel();
    languageCubit = MockLanguageCubit();
    selectedAddressCubit = MockSelectedAddressCubit();
    userAddressViewModel = MockUserAddressViewModel();

    when(languageCubit.state).thenReturn(const Locale('en'));
    when(languageCubit.stream).thenAnswer((_) => const Stream.empty());

    // Stub SelectedAddressCubit
    when(selectedAddressCubit.state).thenReturn(null);
    when(selectedAddressCubit.stream).thenAnswer((_) => const Stream.empty());

    // Stub UserAddressViewModel
    when(userAddressViewModel.state).thenReturn(UserAddressState());
    when(userAddressViewModel.stream).thenAnswer((_) => const Stream.empty());
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
      home: MultiBlocProvider(
        providers: [
          BlocProvider<CheckoutViewModel>.value(value: checkoutCubit),
          BlocProvider<CartViewModel>.value(value: cartCubit),
          BlocProvider<LanguageCubit>.value(value: languageCubit),
          BlocProvider<SelectedAddressCubit>.value(value: selectedAddressCubit),
          BlocProvider<UserAddressViewModel>.value(value: userAddressViewModel),
        ],
        child: const Scaffold(body: CheckOutBody()),
      ),
    );
  }

  // 1. Test Loading State
  testWidgets('checkout button is disabled when loading', (tester) async {
    when(checkoutCubit.state).thenReturn(CheckoutStates(isLoading: true));
    when(
      checkoutCubit.stream,
    ).thenAnswer((_) => Stream.value(CheckoutStates(isLoading: true)));
    when(cartCubit.state).thenReturn(CartStates());
    when(cartCubit.stream).thenAnswer((_) => const Stream.empty());

    await tester.pumpWidget(buildTestableWidget());

    final buttonFinder = find.byType(ElevatedButton);
    await tester.ensureVisible(buttonFinder);

    final button = tester.widget<ElevatedButton>(buttonFinder);
    expect(button.onPressed, isNull);
  });

  // 2. Test Error Message
  testWidgets('shows snackbar when error message exists', (tester) async {
    when(
      checkoutCubit.state,
    ).thenReturn(CheckoutStates(errorMessage: 'Error happened'));
    when(checkoutCubit.stream).thenAnswer(
      (_) => Stream.value(CheckoutStates(errorMessage: 'Error happened')),
    );
    when(cartCubit.state).thenReturn(CartStates());
    when(cartCubit.stream).thenAnswer((_) => const Stream.empty());

    await tester.pumpWidget(buildTestableWidget());
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Error happened'), findsOneWidget);
  });

  // 3. Test Payment Cancelled
  testWidgets('shows payment cancelled snackbar', (tester) async {
    when(
      checkoutCubit.state,
    ).thenReturn(CheckoutStates(isPaymentCancelled: true));
    when(
      checkoutCubit.stream,
    ).thenAnswer((_) => Stream.value(CheckoutStates(isPaymentCancelled: true)));
    when(cartCubit.state).thenReturn(CartStates());
    when(cartCubit.stream).thenAnswer((_) => const Stream.empty());

    await tester.pumpWidget(buildTestableWidget());
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
  });

  // 4. Test Address Selection Requirement
  testWidgets('checkout button is disabled when no address selected', (
    tester,
  ) async {
    when(checkoutCubit.state).thenReturn(const CheckoutStates());
    when(
      checkoutCubit.stream,
    ).thenAnswer((_) => Stream.value(const CheckoutStates()));
    when(cartCubit.state).thenReturn(CartStates());
    when(cartCubit.stream).thenAnswer((_) => const Stream.empty());

    await tester.pumpWidget(buildTestableWidget());

    final buttonFinder = find.byType(ElevatedButton);
    await tester.ensureVisible(buttonFinder);

    final button = tester.widget<ElevatedButton>(buttonFinder);
    expect(button.onPressed, isNull);
  });

  // 5. Test Payment Method Selection
  testWidgets('changing payment method calls onChanged with creditCard', (
    tester,
  ) async {
    PaymentMethod? selected;

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('en')],
        home: Scaffold(
          body: Builder(
            builder: (context) {
              return PaymentMethodSection(
                selectedMethod: PaymentMethod.cash,
                onChanged: (method) => selected = method,
              );
            },
          ),
        ),
      ),
    );

    final BuildContext context = tester.element(
      find.byType(PaymentMethodSection),
    );
    final String creditCardText = AppLocalizations.of(context)!.creditCard;

    await tester.tap(find.text(creditCardText));
    await tester.pump();
    expect(selected, PaymentMethod.creditCard);
  });

  // 6. Test Gift Section
  testWidgets('gift fields appear when switch is enabled', (tester) async {
    when(checkoutCubit.state).thenReturn(const CheckoutStates());
    when(
      checkoutCubit.stream,
    ).thenAnswer((_) => Stream.value(const CheckoutStates()));
    when(cartCubit.state).thenReturn(CartStates());
    when(cartCubit.stream).thenAnswer((_) => const Stream.empty());

    await tester.pumpWidget(buildTestableWidget());

    final switchFinder = find.byType(Switch);
    await tester.ensureVisible(switchFinder);

    expect(find.byKey(const ValueKey('giftFields')), findsNothing);

    await tester.tap(switchFinder);
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey('giftFields')), findsOneWidget);
  });
}
