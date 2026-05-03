import 'package:flowers_app/Features/auth/presentation/forget_password/view_model/forget_password_cubit.dart';
import 'package:flowers_app/Features/auth/presentation/forget_password/view_model/forget_password_states.dart';
import 'package:flowers_app/Features/auth/presentation/forget_password/views/forget_password_screen_flow.dart';
import 'package:flowers_app/Features/auth/presentation/forget_password/widgets/forget_password_screen_flow_body.dart';
import 'package:flowers_app/core/di/di.dart';
import 'package:flowers_app/core/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'forget_password_screen_flow_test.mocks.dart';

@GenerateMocks([ForgetPasswordCubit])
void main() {
  late MockForgetPasswordCubit mockViewModel;

  setUp(() async {
    await getIt.reset();

    mockViewModel = MockForgetPasswordCubit();

    when(mockViewModel.state).thenReturn(ForgetPasswordState());
    when(
      mockViewModel.stream,
    ).thenAnswer((_) => Stream.value(ForgetPasswordState()));

    getIt.registerFactory<ForgetPasswordCubit>(() => mockViewModel);
  });

  tearDown(() async {
    await getIt.reset();
  });

  testWidgets(
    'ForgetPasswordScreenFlow should provide ViewModel and show Body',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const ForgetPasswordScreenFlow(),
        ),
      );

      final blocProviderFinder = find.byType(
        BlocProvider<ForgetPasswordCubit>,
      );
      expect(blocProviderFinder, findsOneWidget);

      final BuildContext context = tester.element(
        find.byType(ForgetPasswordScreenFlowBody),
      );
      final viewModel = BlocProvider.of<ForgetPasswordCubit>(context);

      expect(viewModel, isNotNull);
      expect(find.byType(ForgetPasswordScreenFlowBody), findsOneWidget);
    },
  );
}
