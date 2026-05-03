import 'package:bloc_test/bloc_test.dart';
import 'package:flowers_app/Features/auth/domain/use_cases/get_user_id_usecase.dart';
import 'package:flowers_app/Features/order/data/models/checkout/order_request_dto.dart';
import 'package:flowers_app/Features/order/data/models/checkout/shipping_address_request.dart';
import 'package:flowers_app/Features/order/domain/entities/checkout/cash_checkout_response_entity.dart';
import 'package:flowers_app/Features/order/domain/entities/checkout/credit_checkout_response_entity.dart';
import 'package:flowers_app/Features/order/domain/entities/checkout/order_entity.dart';
import 'package:flowers_app/Features/order/domain/entities/checkout/session_entity.dart';
import 'package:flowers_app/Features/order/domain/use_cases/checkout/cash_order_checkout.dart';
import 'package:flowers_app/Features/order/domain/use_cases/checkout/credit_card_checkout.dart';
import 'package:flowers_app/Features/order/presentation/check_out/view_model/checkout_events.dart';
import 'package:flowers_app/Features/order/presentation/check_out/view_model/checkout_states.dart';
import 'package:flowers_app/Features/order/presentation/check_out/view_model/checkout_view_model.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'checkout_view_model_test.mocks.dart';

@GenerateMocks([CashOrderCheckout, CreditCardCheckout, GetUserIdUseCase])
void main() {
  provideDummy<BaseResponse<CashCheckoutResponseEntity>>(
    SuccessResponse<CashCheckoutResponseEntity>(data: fakeCashResponse),
  );

  provideDummy<BaseResponse<CreditCheckoutResponseEntity>>(
    SuccessResponse<CreditCheckoutResponseEntity>(data: fakeCreditResponse),
  );

  late CheckoutViewModel checkoutViewModel;
  late MockCashOrderCheckout mockCashOrderCheckout;
  late MockCreditCardCheckout mockCreditCardCheckout;
  late MockGetUserIdUseCase mockGetUserIdUseCase;

  CheckoutStates initialState() => const CheckoutStates();

  setUp(() {
    mockCashOrderCheckout = MockCashOrderCheckout();
    mockCreditCardCheckout = MockCreditCardCheckout();
    mockGetUserIdUseCase = MockGetUserIdUseCase();
    when(mockGetUserIdUseCase.call()).thenAnswer((_) async => 'fake_user_id');

    checkoutViewModel = CheckoutViewModel(
      cashOrderCheckout: mockCashOrderCheckout,
      creditCardCheckout: mockCreditCardCheckout,
      getUserIdUseCase: mockGetUserIdUseCase,
    );
  });

  tearDown(() {
    checkoutViewModel.close();
  });

  group('CheckoutViewModel Tests', () {
    blocTest<CheckoutViewModel, CheckoutStates>(
      'CashPaymentEvent emits loading then cashResponse on success',
      build: () {
        _stubCashCheckoutSuccess(mockCashOrderCheckout);
        return checkoutViewModel;
      },
      act: (bloc) => bloc.doIntent(CashPaymentEvent(fakeOrderRequest)),
      expect: () => [
        initialState().copyWith(isLoading: true, errorMessage: null),
        initialState().copyWith(cashResponse: fakeCashResponse),
      ],
    );

    blocTest<CheckoutViewModel, CheckoutStates>(
      'CreditCardPaymentEvent emits loading then redirectUrl on success',
      build: () {
        _stubCreditCheckoutSuccess(mockCreditCardCheckout);
        return checkoutViewModel;
      },
      act: (bloc) => bloc.doIntent(CreditCardPaymentEvent(fakeOrderRequest)),
      expect: () => [
        initialState().copyWith(isLoading: true, errorMessage: null),
        initialState().copyWith(redirectUrl: 'http://localhost/pay'),
      ],
    );

    blocTest<CheckoutViewModel, CheckoutStates>(
      'CashPaymentEvent emits loading then errorMessage on failure',
      build: () {
        when(
          mockCashOrderCheckout.call(any),
        ).thenAnswer((_) async => ErrorResponse(errorMessage: 'Cash failed'));
        return checkoutViewModel;
      },
      act: (bloc) => bloc.doIntent(CashPaymentEvent(fakeOrderRequest)),
      expect: () => [
        initialState().copyWith(isLoading: true, errorMessage: null),
        initialState().copyWith(isLoading: false, errorMessage: 'Cash failed'),
      ],
    );

    blocTest<CheckoutViewModel, CheckoutStates>(
      'CreditCardPaymentEvent emits error when session url is invalid',
      build: () {
        when(mockCreditCardCheckout.call(any)).thenAnswer(
          (_) async => SuccessResponse(
            data: CreditCheckoutResponseEntity(session: SessionEntity(url: '')),
          ),
        );
        return checkoutViewModel;
      },
      act: (bloc) => bloc.doIntent(CreditCardPaymentEvent(fakeOrderRequest)),
      expect: () => [
        initialState().copyWith(isLoading: true, errorMessage: null),
        initialState().copyWith(
          isLoading: false,
          errorMessage: 'Invalid payment session',
        ),
      ],
    );

    blocTest<CheckoutViewModel, CheckoutStates>(
      'OnPaymentCancelEvent emits payment cancelled',
      build: () => checkoutViewModel,
      act: (bloc) => bloc.doIntent(OnPaymentCancelEvent()),
      expect: () => [initialState().copyWith(isPaymentCancelled: true)],
    );

    blocTest<CheckoutViewModel, CheckoutStates>(
      'resetPaymentState clears redirectUrl and cashResponse',
      build: () {
        return CheckoutViewModel(
          cashOrderCheckout: mockCashOrderCheckout,
          creditCardCheckout: mockCreditCardCheckout,
          getUserIdUseCase: mockGetUserIdUseCase,
        );
      },
      seed: () => initialState().copyWith(
        redirectUrl: 'url',
        cashResponse: fakeCashResponse,
      ),
      act: (bloc) => bloc.resetPaymentState(),
      expect: () => [
        initialState().copyWith(redirectUrl: null, cashResponse: null),
      ],
    );
  });
  blocTest<CheckoutViewModel, CheckoutStates>(
    'CreditCardPaymentEvent emits errorMessage on failure',
    build: () {
      when(
        mockCreditCardCheckout.call(any),
      ).thenAnswer((_) async => ErrorResponse(errorMessage: 'Credit failed'));
      return checkoutViewModel;
    },
    act: (bloc) => bloc.doIntent(CreditCardPaymentEvent(fakeOrderRequest)),
    expect: () => [
      initialState().copyWith(isLoading: true, errorMessage: null),
      initialState().copyWith(isLoading: false, errorMessage: 'Credit failed'),
    ],
  );
}

/// -------------------- STUBS --------------------

void _stubCashCheckoutSuccess(MockCashOrderCheckout mock) {
  when(mock.call(any)).thenAnswer(
    (_) async =>
        SuccessResponse<CashCheckoutResponseEntity>(data: fakeCashResponse),
  );
}

void _stubCreditCheckoutSuccess(MockCreditCardCheckout mock) {
  when(mock.call(any)).thenAnswer(
    (_) async =>
        SuccessResponse<CreditCheckoutResponseEntity>(data: fakeCreditResponse),
  );
}

/// -------------------- FAKE DATA --------------------
final fakeShippingAddress = ShippingAddressRequest(
  street: 'Test Street',
  phone: '01000000000',
  city: 'Cairo',
  lat: '30.0444',
  long: '31.2357',
);

final fakeOrderRequest = OrderRequest(shippingAddress: fakeShippingAddress);

final fakeCashResponse = CashCheckoutResponseEntity(
  order: OrderEntity(id: 'order_456', user: 'fake_user_id'),
);

final fakeCreditResponse = CreditCheckoutResponseEntity(
  session: SessionEntity(
    id: 'session_id',
    clientReferenceId: 'order_123',
    url: 'http://localhost/pay',
  ),
);
