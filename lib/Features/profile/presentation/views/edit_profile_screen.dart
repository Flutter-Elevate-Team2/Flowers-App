import 'package:flowers_app/Features/profile/presentation/widgets/edit_profile_app_bar.dart';
import 'package:flowers_app/Features/profile/presentation/widgets/gender_selection_section.dart';
import 'package:flowers_app/Features/profile/presentation/widgets/profile_avatar.dart';
import 'package:flowers_app/Features/profile/presentation/widgets/profile_text_form_feild.dart';
import 'package:flowers_app/Features/profile/presentation/widgets/update_profile_buttom.dart';
import 'package:flowers_app/core/app_router/app_router.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const EditProfileAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          children: [
            const ProfileAvatarSection(),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: ProfileTextField(
                    label: context.l10n.firstNameLabel,
                    initialValue: "Nour",
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ProfileTextField(
                    label: context.l10n.lastNameLabel,
                    initialValue: "Mohamed",
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ProfileTextField(
              label: context.l10n.emailLabel,
              initialValue: "NourMohamed12@gmail.com",
            ),
            const SizedBox(height: 16),
            ProfileTextField(
              label: context.l10n.phoneLabel,
              initialValue: "01001234567",
            ),
            const SizedBox(height: 16),
            ProfileTextField(
              label: context.l10n.passwordLabel,
              initialValue: "********",
              isObscure: true,
              trailing: Padding(
                padding: const EdgeInsets.only(right: 16),
                child: TextButton(
                  onPressed: () {
                    context.pushNamed(Routes.resetPasswordName);
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(50, 30),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    alignment: Alignment.centerRight,
                  ),
                  child: Text(
                    context.l10n.change,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            const GenderSelectionSection(),
            const SizedBox(height: 48),
            const UpdateProfileButton(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
