import 'package:flowers_app/Features/order/presentation/cart/widgets/shared/add_to_cart_button/login_required_dialog.dart';
import 'package:flowers_app/core/app_router/app_router.dart';
import 'package:flowers_app/core/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Generate Mock for GoRouter
@GenerateMocks([GoRouter])
import 'login_required_dialog_test.mocks.dart';

void main() {
  late MockGoRouter mockRouter;

  setUp(() {
    mockRouter = MockGoRouter();

    // Stub canPop to return true so the logic inside the dialog executes
    when(mockRouter.canPop()).thenReturn(true);

    // Stub pushNamed to avoid MissingStubError
    // We use any for parameters because GoRouter passes empty maps by default
    when(mockRouter.pushNamed(
      any,
      pathParameters: anyNamed('pathParameters'),
      queryParameters: anyNamed('queryParameters'),
      extra: anyNamed('extra'),
    )).thenAnswer((_) async => null);

    // Stub pop
    when(mockRouter.pop()).thenReturn(null);
  });

  Widget createWidgetUnderTest(String content) {
    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en'), Locale('ar')],
      home: InheritedGoRouter(
        goRouter: mockRouter,
        child: Scaffold(
          body: LoginRequiredDialog(content: content),
        ),
      ),
    );
  }

  group('LoginRequiredDialog Widget Tests', () {
    const testContent = 'Please login to continue';

    testWidgets('should display the correct content and localized title', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest(testContent));

      expect(find.text(testContent), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.byType(OutlinedButton), findsOneWidget);
    });

    testWidgets('should close dialog when Cancel button is pressed', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest(testContent));

      final cancelButton = find.byType(OutlinedButton);
      await tester.tap(cancelButton);
      await tester.pumpAndSettle();

      verify(mockRouter.pop()).called(1);
    });

    testWidgets('should close dialog and navigate to SignIn when Login button is pressed', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest(testContent));

      final loginButton = find.byType(ElevatedButton);
      await tester.tap(loginButton);
      await tester.pumpAndSettle();

      // Verify pop was called
      verify(mockRouter.pop()).called(1);

      // Verify navigation to SignIn was called with correct arguments
      verify(mockRouter.pushNamed(
        Routes.signInName,
        pathParameters: anyNamed('pathParameters'),
        queryParameters: anyNamed('queryParameters'),
        extra: anyNamed('extra'),
      )).called(1);
    });
  });
}