import 'dart:async';
import 'package:bloc_test/bloc_test.dart';
import 'package:flowers_app/Features/commerce/domain/entities/home_entities/category_entity.dart';
import 'package:flowers_app/Features/commerce/domain/entities/home_entities/home_entity.dart';
import 'package:flowers_app/Features/commerce/domain/entities/home_entities/occasion_entity.dart';
import 'package:flowers_app/Features/commerce/presentation/home/view_model/home_events.dart';
import 'package:flowers_app/Features/commerce/presentation/home/view_model/home_states.dart';
import 'package:flowers_app/Features/commerce/presentation/home/view_model/home_view_model.dart';
import 'package:flowers_app/Features/commerce/presentation/home/widgets/sections/home_categories_section.dart';
import 'package:flowers_app/Features/commerce/presentation/home/widgets/shared/home_content_widget.dart';
import 'package:flowers_app/Features/user_address/presentation/view_model/user_address_view_model.dart';
import 'package:flowers_app/Features/user_address/presentation/view_model/user_address_state.dart';
import 'package:flowers_app/Features/user_address/domain/entities/address_entity.dart';
import 'package:flowers_app/core/l10n/app_localizations.dart';
import 'package:flowers_app/core/widget/selected_address_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

class FakeHomeEvent extends Fake implements GetHomeDataEvent {}

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
  late HomeEntity testHomeData;

  setUpAll(() {
    registerFallbackValue(FakeHomeEvent());
  });

  setUp(() {
    mockHomeViewModel = MockHomeViewModel();
    mockUserAddressViewModel = MockUserAddressViewModel();
    mockSelectedAddressCubit = MockSelectedAddressCubit();

    testHomeData = HomeEntity(
      categories: [
        CategoryEntity(id: '1', name: 'Flowers', icon: 'http://img1.png'),
        CategoryEntity(id: '2', name: 'Plants', icon: 'http://img2.png'),
      ],
      bestSellers: [],
      occasions: [
        OccasionEntity(id: '1', name: 'Birthday', imageUrl: 'http://occ1.png'),
      ],
    );

    when(() => mockHomeViewModel.state).thenReturn(HomeStates());
    when(
      () => mockHomeViewModel.stream,
    ).thenAnswer((_) => Stream.value(HomeStates()));
    when(() => mockUserAddressViewModel.state).thenReturn(UserAddressState());
    when(
      () => mockUserAddressViewModel.stream,
    ).thenAnswer((_) => Stream.value(UserAddressState()));
    when(() => mockSelectedAddressCubit.state).thenReturn(null);
    when(
      () => mockSelectedAddressCubit.stream,
    ).thenAnswer((_) => Stream.value(null));
  });

  Widget createWidgetUnderTest({HomeEntity? data}) {
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
        child: Scaffold(
          body: HomeContentWidget(homeData: data ?? testHomeData),
        ),
      ),
    );
  }

  group('HomeContentWidget Tests', () {
    testWidgets('Success State: renders sections correctly', (tester) async {
      await mockNetworkImages(() async {
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pump(const Duration(milliseconds: 500));
        expect(find.byType(HomeCategoriesSection), findsOneWidget);
        expect(find.text('Flowers'), findsOneWidget);
      });
    });

    testWidgets('Interaction: RefreshIndicator triggers action', (
      tester,
    ) async {
      await mockNetworkImages(() async {
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pump(const Duration(milliseconds: 500));

        final scrollableFinder = find.byType(SingleChildScrollView);

        await tester.drag(scrollableFinder, const Offset(0, 400));

        for (int i = 0; i < 50; i++) {
          await tester.pump(const Duration(milliseconds: 20));
        }

        verify(
          () => mockHomeViewModel.doIntent(any()),
        ).called(greaterThanOrEqualTo(1));
      });
    });
  });
}
