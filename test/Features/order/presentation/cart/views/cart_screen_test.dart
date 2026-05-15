 import 'package:flowers_app/Features/order/presentation/cart/view_model/cart_states.dart';
import 'package:flowers_app/Features/order/presentation/cart/view_model/cart_view_model.dart';
 import 'package:flowers_app/Features/order/presentation/cart/views/cart_screen.dart';
import 'package:flowers_app/Features/order/presentation/cart/widgets/cart_product_card/empty_cart_view.dart';
import 'package:flowers_app/Features/order/presentation/cart/widgets/cart_product_card/guest_cart_view.dart';
import 'package:flowers_app/Features/order/presentation/cart/widgets/cart_product_card/shimmer/cart_body_shimmer.dart';
import 'package:flowers_app/core/l10n/app_localizations.dart';
import 'package:flowers_app/core/l10n/view_model/language_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Import generated mocks
@GenerateMocks([CartViewModel, LanguageCubit])
import 'cart_screen_test.mocks.dart';

void main() {
  late MockCartViewModel mockCartViewModel;
  late MockLanguageCubit mockLanguageCubit;

  setUp(() {
    mockCartViewModel = MockCartViewModel();
    mockLanguageCubit = MockLanguageCubit();

    // إعداد حالة اللغة الافتراضية
    when(mockLanguageCubit.state).thenReturn(const Locale('en'));
    when(mockLanguageCubit.stream).thenAnswer((_) => const Stream.empty());

    // إعداد الـ Stream الخاص بالـ CartViewModel لمنع أخطاء الـ BlocBuilder
    when(mockCartViewModel.stream).thenAnswer((_) => const Stream.empty());
  });

  Widget createTestableWidget() {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CartViewModel>.value(value: mockCartViewModel),
        BlocProvider<LanguageCubit>.value(value: mockLanguageCubit),
      ],
      child: MaterialApp(
        // هؤلاء هم المفاتيح الناقصة لحل مشكلة الـ Null check operator
        localizationsDelegates: const [
          AppLocalizations.delegate, // استبدل AppLocalizations باسم كلاس الـ l10n عندك
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'),
          Locale('ar'),
        ],
        locale: const Locale('en'), // اللغة التي تريد تشغيل التيست بها
        home: const CartScreen(),
      ),
    );
  }
  testWidgets('should display CartBodyShimmer when state is loading', (tester) async {
    // Arrange
    when(mockCartViewModel.state).thenReturn(CartStates(isLoading: true));

    // Act
    await tester.pumpWidget(createTestableWidget());

    // Assert
    expect(find.byType(CartBodyShimmer), findsOneWidget);
  });

  testWidgets('should display GuestCartView when user is guest', (tester) async {
    // Arrange
    when(mockCartViewModel.state).thenReturn(CartStates(isGuest: true, isLoading: false));

    // Act
    await tester.pumpWidget(createTestableWidget());

    // Assert
    expect(find.byType(GuestCartView), findsOneWidget);
  });

  testWidgets('should display EmptyCartView when cart is empty', (tester) async {
    // Arrange
    when(mockCartViewModel.state).thenReturn(
        CartStates(
          isLoading: false,
          isGuest: false,
          cartData: null, // تأكد أن كودك في الـ CartScreen بيتعامل مع الـ null كـ empty
        )
    );
    // تأكد من عمل stub للـ stream دائماً
    when(mockCartViewModel.stream).thenAnswer((_) => const Stream.empty());

    // Act
    await tester.pumpWidget(createTestableWidget());
    await tester.pump(); // مهم جداً لإعطاء فرصة للـ UI ليرسم

    // Assert
    expect(find.byType(EmptyCartView), findsOneWidget);
  });}