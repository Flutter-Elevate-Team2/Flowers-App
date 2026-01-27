import 'package:flowers_app/Features/commerce/presentation/home/view_model/home_events.dart';
import 'package:flowers_app/Features/commerce/presentation/home/view_model/home_states.dart';
import 'package:flowers_app/Features/commerce/presentation/home/view_model/home_view_model.dart';
import 'package:flowers_app/Features/commerce/presentation/home/widgets/shared/home_content_widget.dart';
import 'package:flowers_app/Features/commerce/presentation/home/widgets/shared/home_error_widget.dart';
import 'package:flowers_app/Features/commerce/presentation/home/widgets/shimmers/home_shimmer_loading.dart';
import 'package:flowers_app/Features/user_address/presentation/view_model/user_address_event.dart';
import 'package:flowers_app/Features/user_address/presentation/view_model/user_address_view_model.dart';
import 'package:flowers_app/core/di/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              getIt<HomeViewModel>()..doIntent(GetHomeDataEvent()),
        ),
        BlocProvider(
          create: (context) =>
              getIt<UserAddressViewModel>()..doIntent(GetAddressesEvent()),
        ),
      ],
      child: BlocBuilder<HomeViewModel, HomeStates>(
        builder: (context, state) {
          final homeState = state.homeState;

          if (homeState?.isLoading == true) {
            return const Center(child: HomeShimmerLoading());
          }

          if (homeState?.errorMessage != null) {
            return HomeErrorWidget(errorMessage: homeState!.errorMessage!);
          }

          final homeData = homeState?.data;

          if (homeData != null) {
            return HomeContentWidget(homeData: homeData);
          }

          return const SizedBox();
        },
      ),
    );
  }
}
