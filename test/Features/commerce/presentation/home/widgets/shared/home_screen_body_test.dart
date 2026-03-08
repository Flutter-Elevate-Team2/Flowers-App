import 'package:bloc_test/bloc_test.dart';
import 'package:flowers_app/Features/commerce/domain/entities/home_entities/home_entity.dart';
import 'package:flowers_app/Features/commerce/presentation/home/view_model/home_events.dart';
import 'package:flowers_app/Features/commerce/presentation/home/view_model/home_states.dart';
import 'package:flowers_app/Features/commerce/presentation/home/view_model/home_view_model.dart';
import 'package:flowers_app/Features/commerce/presentation/home/widgets/shared/home_content_widget.dart';
import 'package:flowers_app/Features/commerce/presentation/home/widgets/shared/home_error_widget.dart';
import 'package:flowers_app/Features/commerce/presentation/home/widgets/shared/home_screen_body.dart';
import 'package:flowers_app/Features/commerce/presentation/home/widgets/shimmers/home_shimmer_loading.dart';
import 'package:flowers_app/Features/user_address/domain/entities/address_entity.dart'; // تأكد من المسار
import 'package:flowers_app/Features/user_address/presentation/view_model/user_address_state.dart';
import 'package:flowers_app/Features/user_address/presentation/view_model/user_address_view_model.dart';
import 'package:flowers_app/core/base_states/base_states.dart';
import 'package:flowers_app/core/di/di.dart';
import 'package:flowers_app/core/l10n/app_localizations.dart';
import 'package:flowers_app/core/widget/selected_address_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

class MockHomeViewModel extends MockCubit<HomeStates>
    implements HomeViewModel {}

class MockUserAddressViewModel extends MockCubit<UserAddressState>
    implements UserAddressViewModel {}

class MockSelectedAddressCubit extends MockCubit<AddressEntity?>
    implements SelectedAddressCubit {}

void main() {
  late MockHomeViewModel mockHomeViewModel;
  late MockUserAddressViewModel mockUserAddressViewModel;
  late MockSelectedAddressCubit mockSelectedAddressCubit;

  setUpAll(() async {
    registerFallbackValue(GetHomeDataEvent());
    await GetIt.instance.reset();
  });

  setUp(() {
    mockHomeViewModel = MockHomeViewModel();
    mockUserAddressViewModel = MockUserAddressViewModel();
    mockSelectedAddressCubit = MockSelectedAddressCubit();

    when(() => mockUserAddressViewModel.state).thenReturn(UserAddressState());
    when(() => mockSelectedAddressCubit.state).thenReturn(null);

    if (!getIt.isRegistered<HomeViewModel>()) {
      getIt.registerFactory<HomeViewModel>(() => mockHomeViewModel);
    }
  });

  tearDown(() async {
    await getIt.reset();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: MultiBlocProvider(
        providers: [
          BlocProvider<HomeViewModel>.value(value: mockHomeViewModel),
          BlocProvider<UserAddressViewModel>.value(
            value: mockUserAddressViewModel,
          ),
          BlocProvider<SelectedAddressCubit>.value(
            value: mockSelectedAddressCubit,
          ),
        ],
        child: const Scaffold(body: HomeScreenBody()),
      ),
    );
  }

  group('HomeScreenBody - Dependency Resolution Tests', () {
    testWidgets('Loading State: shows HomeShimmerLoading', (tester) async {
      when(
        () => mockHomeViewModel.state,
      ).thenReturn(HomeStates(homeState: const BaseState(isLoading: true)));

      await tester.pumpWidget(createWidgetUnderTest());
      expect(find.byType(HomeShimmerLoading), findsOneWidget);
    });

    testWidgets('Error State: shows HomeErrorWidget', (tester) async {
      const errorMessage = 'Network Error';
      when(() => mockHomeViewModel.state).thenReturn(
        HomeStates(homeState: const BaseState(errorMessage: errorMessage)),
      );

      await tester.pumpWidget(createWidgetUnderTest());
      expect(find.byType(HomeErrorWidget), findsOneWidget);
      expect(find.textContaining('Network Error'), findsOneWidget);
    });

    testWidgets('Success State: handles images and renders content', (
      tester,
    ) async {
      final homeData = HomeEntity(
        categories: [],
        bestSellers: [],
        occasions: [],
      );
      when(() => mockHomeViewModel.state).thenReturn(
        HomeStates(homeState: BaseState(data: homeData, isLoading: false)),
      );

      await mockNetworkImages(() async {
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pump();
        expect(find.byType(HomeContentWidget), findsOneWidget);
      });
    });
  });
}
