import 'package:flowers_app/Features/notifications/presentation/view_model/notification_state.dart';
import 'package:flowers_app/Features/notifications/presentation/view_model/notification_view_model.dart';
import 'package:flowers_app/Features/profile/presentation/view_model/profile_state.dart';
import 'package:flowers_app/Features/profile/presentation/view_model/profile_view_model.dart';
import 'package:flowers_app/Features/profile/presentation/widgets/guest_profile_view.dart';
import 'package:flowers_app/Features/profile/presentation/widgets/language_bottom_sheet.dart';
import 'package:flowers_app/Features/profile/presentation/widgets/logout_dialog.dart';
import 'package:flowers_app/Features/profile/presentation/widgets/profile_header.dart';
import 'package:flowers_app/Features/profile/presentation/widgets/profile_header_shimmer.dart';
import 'package:flowers_app/Features/profile/presentation/widgets/profile_menu_item.dart';
import 'package:flowers_app/core/app_router/app_router.dart';
import 'package:flowers_app/core/constants/app_colors.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flowers_app/core/l10n/view_model/language_cubit.dart';
import 'package:flowers_app/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class ProfileScreenBody extends StatefulWidget {
  const ProfileScreenBody({super.key});

  @override
  State<ProfileScreenBody> createState() => _ProfileScreenBodyState();
}

class _ProfileScreenBodyState extends State<ProfileScreenBody> {
  @override
  void initState() {
    super.initState();
    // Load local notification preference when the screen initializes.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileViewModel>().loadNotificationPreference();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileViewModel, ProfileState>(
      builder: (context, state) {
        final profileState = state.profileState;
        final languageViewModel = context.read<LanguageCubit>();

        if (profileState?.isLoading == true) {
          return const SafeArea(child: ProfileHeaderShimmer());
        }
        if (profileState?.data == null && profileState?.errorMessage == null) {
          return const GuestProfileView();
        }
        if (profileState?.errorMessage != null) {
          return Center(
            child: Text(
              profileState!.errorMessage!,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          );
        }

        return SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const ProfileAppBar(),
                const SizedBox(height: 16),

                ProfileHeader(user: profileState?.data),

                const SizedBox(height: 32),

                ProfileMenuItem(
                  title: context.l10n.myOrders,
                  leadingIcon: Icons.calendar_today_outlined,
                  onTap: () {
                    context.pushNamed(Routes.orderName);
                  },
                ),
                ProfileMenuItem(
                  title: context.l10n.savedAddress,
                  leadingIcon: Icons.location_on_outlined,
                  onTap: () {
                    context.pushNamed(Routes.savedAddressName);
                  },
                ),
                Divider(color: AppColors.gray, height: 32),

                ProfileMenuItem(
                  title: context.l10n.notifications,
                  leadingIcon: Icons.notifications_none_outlined,
                  titleColor: Theme.of(
                    context,
                  ).colorScheme.surfaceContainerHighest,
                  trailing: Switch(
                    value: state.isNotificationsEnabled,
                    onChanged: (val) {
                      context.read<ProfileViewModel>().toggleNotifications(val);
                    },
                    activeThumbColor: Theme.of(context).primaryColor,
                    activeTrackColor: Theme.of(
                      context,
                    ).colorScheme.primary.withValues(alpha: 0.2),
                    inactiveThumbColor: Colors.grey,
                    inactiveTrackColor: Colors.grey.withValues(alpha: 0.2),
                  ),
                ),
                Divider(color: AppColors.gray, height: 32),

                ProfileMenuItem(
                  title: context.l10n.language,
                  leadingIcon: Icons.translate,
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        languageViewModel.state.languageCode == 'ar'
                            ? context.l10n.arabic
                            : context.l10n.english,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (context) =>
                          LanguageBottomSheet(viewModel: languageViewModel),
                    );
                  },
                ),
                ProfileMenuItem(
                  title: context.l10n.aboutUs,
                  leadingIcon: Icons.info_outline,
                  onTap: () {
                    context.pushNamed(Routes.aboutpageName);
                  },
                ),
                ProfileMenuItem(
                  title: context.l10n.termsAndConditions,
                  leadingIcon: Icons.description_outlined,
                  onTap: () {
                    context.pushNamed(Routes.termsandConditionsName);
                  },
                ),
                Divider(color: AppColors.gray, height: 32),

                ProfileMenuItem(
                  title: context.l10n.logout,
                  leadingIcon: Icons.logout,
                  onTap: () {
                    final viewModel = context.read<ProfileViewModel>();
                    showDialog(
                      context: context,
                      builder: (dialogContext) => BlocProvider.value(
                        value: viewModel,
                        child: const LogoutDialog(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 32),
                Center(
                  child: Text(
                    context.l10n.appVersion,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(
                        context,
                      ).colorScheme.surfaceContainerHighest,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ProfileAppBar extends StatelessWidget {
  const ProfileAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationViewModel, NotificationState>(
      buildWhen: (previous, current) =>
          previous.unreadCount != current.unreadCount,
      builder: (context, notificationState) {
        final unreadCount = notificationState.unreadCount;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            children: [
              SvgPicture.asset(Assets.icons.flowerLogo, height: 25),
              const SizedBox(width: 8),
              Text(
                context.l10n.flowery,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  IconButton(
                    icon: const Icon(Icons.notifications_none_outlined),
                    iconSize: 28,
                    color: Theme.of(context).iconTheme.color,
                    onPressed: () {
                      context.pushNamed(Routes.notificationsName);
                    },
                  ),
                  if (unreadCount > 0)
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.error,
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          unreadCount > 99 ? '99+' : '$unreadCount',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onError,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
