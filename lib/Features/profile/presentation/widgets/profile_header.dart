
import 'package:flowers_app/Features/profile/domain/entities/user_entity.dart';
import 'package:flowers_app/Features/profile/presentation/view_model/profile_state.dart';
import 'package:flowers_app/Features/profile/presentation/view_model/profile_view_model.dart';
import 'package:flowers_app/core/app_router/app_router.dart';
import 'package:flowers_app/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class ProfileHeader extends StatelessWidget {
  final UserEntity? user;

  const ProfileHeader({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileViewModel, ProfileState>(
      builder: (context, state) {
        final selectedImage = state.selectedProfileImage;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 45,
              backgroundColor: Colors.transparent,
              backgroundImage: selectedImage != null
                  ? FileImage(selectedImage)
                  : (user?.photoUrl != null && user!.photoUrl.isNotEmpty)
                  ? NetworkImage(user!.photoUrl)
                  : null,
              child:
                  (user?.photoUrl == null || user!.photoUrl.isEmpty) &&
                      selectedImage == null
                  ? SvgPicture.asset(Assets.icons.photo, width: 90, height: 90)
                  : null,
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  user != null
                      ? "${user!.firstName} ${user!.lastName}"
                      : "Guest",
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 4),
                GestureDetector(
                  onTap: () {
                    context.pushNamed(Routes.editProfileName);
                  },
                  child: Icon(
                    Icons.edit,
                    size: 16,
                    color: Theme.of(
                      context,
                    ).colorScheme.surfaceContainerHighest,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              user?.email ?? "",
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
              ),
            ),
          ],
        );
      },
    );
  }
}
