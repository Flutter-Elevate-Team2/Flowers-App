import 'package:flowers_app/Features/profile/presentation/widgets/language_bottom_sheet.dart';
import 'package:flowers_app/Features/profile/presentation/widgets/profile_menu_item.dart';
import 'package:flowers_app/Features/profile/presentation/widgets/profile_screen_body.dart';
import 'package:flowers_app/core/app_router/app_router.dart';
import 'package:flowers_app/core/constants/app_colors.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flowers_app/core/l10n/view_model/language_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class GuestProfileView extends StatelessWidget {
  const GuestProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final languageViewModel = context.read<LanguageCubit>();

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const ProfileAppBar(),
            const SizedBox(height: 24),

            // Guest Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Theme.of(context).colorScheme.primary,
                        width: 1.5,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 36,
                      backgroundColor: Theme.of(context).colorScheme.surface,
                      child: Icon(
                        Icons.person_outline,
                        size: 36,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    context.l10n.guest,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            // Language
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
            const SizedBox(height: 24),
            Divider(color: AppColors.gray, height: 32),

            ProfileMenuItem(
              title: context.l10n.loginButton,
              leadingIcon: Icons.login,
              titleColor: Theme.of(context).colorScheme.primary,
              onTap: () {
                context.pushNamed(Routes.signInName);
              },
            ),
            const SizedBox(height: 32),
            Center(
              child: Text(
                context.l10n.appVersion,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context)
                      .colorScheme
                      .surfaceContainerHighest,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
