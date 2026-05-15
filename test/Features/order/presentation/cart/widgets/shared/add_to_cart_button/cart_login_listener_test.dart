import 'dart:async';
import 'package:flowers_app/Features/order/presentation/cart/view_model/cart_events.dart';
import 'package:flowers_app/Features/order/presentation/cart/view_model/cart_states.dart';
import 'package:flowers_app/Features/order/presentation/cart/view_model/cart_view_model.dart';
import 'package:flowers_app/Features/order/presentation/cart/widgets/shared/add_to_cart_button/cart_login_listener.dart';
import 'package:flowers_app/Features/order/presentation/cart/widgets/shared/add_to_cart_button/login_required_dialog.dart';
import 'package:flowers_app/core/l10n/app_localizations.dart'; // تأكد من المسار
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([CartViewModel])
import 'cart_login_listener_test.mocks.dart';

void main() {
  late MockCartViewModel mockCartViewModel;
  late StreamController<CartStates> statesController;

  setUp(() {
    mockCartViewModel = MockCartViewModel();
    statesController = StreamController<CartStates>.broadcast();

    // إعدادات افتراضية
    when(mockCartViewModel.stream).thenAnswer((_) => statesController.stream);
  });

  tearDown(() {
    statesController.close();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      // 1. إضافة الـ Localizations لحل مشكلة الـ Null Check
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en'), Locale('ar')],
      home: Scaffold(
        body: BlocProvider<CartViewModel>.value(
          value: mockCartViewModel,
          child: const CartLoginListener(
            child: SizedBox(key: Key('child_widget')),
          ),
        ),
      ),
    );
  }

  testWidgets('يجب أن يظهر LoginRequiredDialog عندما تتغير حالة requiresLogin إلى true', (tester) async {
    // إعداد الحالة الأولية (false)
    when(mockCartViewModel.state).thenReturn(const CartStates(requiresLogin: false));

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump(); // تأكد من بناء الـ Widget الأولية

    // تغيير الحالة إلى true
    final newState = const CartStates(requiresLogin: true);
    when(mockCartViewModel.state).thenReturn(newState);
    statesController.add(newState);

    // نستخدم pump عدة مرات للسماح للـ Listener بالتقاط التغيير وبدء الـ Animation الخاص بالـ Dialog
    await tester.pump();
    await tester.pumpAndSettle(); // انتظار انتهاء ظهور الـ Dialog

    // Assert: التحقق من ظهور الـ Dialog
    expect(find.byType(LoginRequiredDialog), findsOneWidget);

    // إغلاق الـ Dialog (الضغط خارج الـ Dialog)
    // لاحظ: في الـ Test قد نحتاج للضغط على زر محدد أو استخدام tapAt
    await tester.tapAt(const Offset(10, 10));
    await tester.pumpAndSettle();

    // التحقق من إرسال الـ Event
    verify(mockCartViewModel.doIntent(argThat(isA<CartLoginHandledEvent>()))).called(1);
  });

  testWidgets('لا يجب أن يظهر Dialog إذا لم تتغير حالة requiresLogin', (tester) async {
    when(mockCartViewModel.state).thenReturn(const CartStates(requiresLogin: false));

    await tester.pumpWidget(createWidgetUnderTest());

     statesController.add(const CartStates(requiresLogin: false));
    await tester.pumpAndSettle();

    expect(find.byType(LoginRequiredDialog), findsNothing);
  });
}