import 'dart:io';

import 'package:flowers_app/Features/profile/presentation/view_model/profile_event.dart';
import 'package:flowers_app/Features/profile/presentation/view_model/profile_state.dart';
import 'package:flowers_app/Features/profile/presentation/view_model/profile_view_model.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flowers_app/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

class ProfileAvatarSection extends StatelessWidget {
  final String? photoUrl;

  const ProfileAvatarSection({super.key, this.photoUrl});

  Future<void> _pickImage(BuildContext context) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (pickedFile != null && context.mounted) {
        final File selectedImage = File(pickedFile.path);

        context.read<ProfileViewModel>().doIntent(
          SelectProfileImageEvent(selectedImage),
        );

        context.read<ProfileViewModel>().doIntent(
          UploadPhotoEvent(selectedImage),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(context.l10n.failedToPickImage(e.toString())),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileViewModel, ProfileState>(
      builder: (context, state) {
        final selectedImage = state.selectedProfileImage;
        final isUploading = state.uploadPhotoState?.isLoading ?? false;

        return Center(
          child: Stack(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.transparent,
                backgroundImage: selectedImage != null
                    ? FileImage(selectedImage)
                    : (photoUrl != null && photoUrl!.isNotEmpty
                              ? NetworkImage(photoUrl!)
                              : null)
                          as ImageProvider?,
                child:
                    (photoUrl == null || photoUrl!.isEmpty) &&
                        selectedImage == null
                    ? SvgPicture.asset(
                        Assets.icons.photo,
                        width: 80,
                        height: 80,
                      )
                    : null,
              ),
              if (isUploading)
                Positioned.fill(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.black54,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 3,
                      ),
                    ),
                  ),
                ),
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () => _pickImage(context),
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).colorScheme.primary.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Theme.of(context).colorScheme.surface,
                        width: 2,
                      ),
                    ),
                    child: Icon(
                      Icons.camera_alt_outlined,
                      size: 14,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
