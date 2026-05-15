import 'package:flowers_app/Features/profile/data/models/edit_profile_request.dart';
import 'package:flowers_app/Features/profile/presentation/view_model/profile_event.dart';
import 'package:flowers_app/Features/profile/presentation/view_model/profile_state.dart';
import 'package:flowers_app/Features/profile/presentation/view_model/profile_view_model.dart';
import 'package:flowers_app/Features/profile/presentation/widgets/edit_profile_app_bar.dart';
import 'package:flowers_app/Features/profile/presentation/widgets/gender_selection_section.dart';
import 'package:flowers_app/Features/profile/presentation/widgets/profile_avatar.dart';
import 'package:flowers_app/Features/profile/presentation/widgets/profile_text_form_feild.dart';
import 'package:flowers_app/Features/profile/presentation/widgets/edit_profile_shimmer.dart';
import 'package:flowers_app/Features/profile/presentation/widgets/update_profile_buttom.dart';
import 'package:flowers_app/core/app_router/app_router.dart';
import 'package:flowers_app/core/constants/app_colors.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flowers_app/core/helpers/form_validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _gender = "female"; // Default

  @override
  void initState() {
    super.initState();
    final state = context.read<ProfileViewModel>().state;
    final profileData = state.profileState?.data;
    if (profileData != null) {
      _firstNameController.text = profileData.firstName;
      _lastNameController.text = profileData.lastName;
      _emailController.text = profileData.email;
      _phoneController.text = profileData.phone;
      _gender = profileData.gender.toLowerCase();
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const EditProfileAppBar(),
      body: MultiBlocListener(
        listeners: [
          BlocListener<ProfileViewModel, ProfileState>(
            listenWhen: (previous, current) =>
                previous.profileState != current.profileState,
            listener: (context, state) {
              final profileData = state.profileState?.data;
              if (profileData != null && _firstNameController.text.isEmpty) {
                _firstNameController.text = profileData.firstName;
                _lastNameController.text = profileData.lastName;
                _emailController.text = profileData.email;
                _phoneController.text = profileData.phone;
                setState(() {
                  _gender = profileData.gender.toLowerCase();
                });
              }
            },
          ),
          BlocListener<ProfileViewModel, ProfileState>(
            listenWhen: (previous, current) =>
                previous.editProfileState != current.editProfileState &&
                previous.editProfileState?.isLoading == true &&
                current.editProfileState?.isLoading == false,
            listener: (context, state) {
              final editState = state.editProfileState;
              if (editState?.errorMessage != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(editState!.errorMessage!),
                    backgroundColor: Theme.of(context).colorScheme.error,
                  ),
                );
              } else if (editState?.data != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                   SnackBar(
                    content: Text(context.l10n.profileUpdatedSuccess),
                    backgroundColor: AppColors.green,
                  ),
                );
              }
            },
          ),
          BlocListener<ProfileViewModel, ProfileState>(
            listenWhen: (previous, current) =>
                previous.uploadPhotoState != current.uploadPhotoState &&
                previous.uploadPhotoState?.isLoading == true &&
                current.uploadPhotoState?.isLoading == false,
            listener: (context, state) {
              final uploadState = state.uploadPhotoState;
              if (uploadState?.errorMessage != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(uploadState!.errorMessage!),
                    backgroundColor: Theme.of(context).colorScheme.error,
                  ),
                );
              } else if (uploadState?.data != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                   SnackBar(
                    content: Text(context.l10n.photoUploadedSuccessfully),
                    backgroundColor: AppColors.green,
                  ),
                );
              }
            },
          ),
        ],
        child: Builder(
          builder: (context) {
            return BlocBuilder<ProfileViewModel, ProfileState>(
              builder: (context, state) {
                if (state.profileState?.isLoading == true) {
                  return const EditProfileShimmer();
                }

                return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 24.0,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        ProfileAvatarSection(
                          photoUrl: state.profileState?.data?.photoUrl,
                        ),
                        const SizedBox(height: 32),
                        Row(
                          children: [
                            Expanded(
                              child: ProfileTextField(
                                label: context.l10n.firstNameLabel,
                                controller: _firstNameController,
                                validator: (v) =>
                                    FormValidators.validateRequired(
                                      v,
                                      context.l10n.required,
                                    ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: ProfileTextField(
                                label: context.l10n.lastNameLabel,
                                controller: _lastNameController,
                                validator: (v) =>
                                    FormValidators.validateRequired(
                                      v,
                                      context.l10n.required,
                                    ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        ProfileTextField(
                          label: context.l10n.emailLabel,
                          controller: _emailController,
                          validator: (v) =>
                              FormValidators.validateEmail(context, v),
                        ),
                        const SizedBox(height: 16),
                        ProfileTextField(
                          label: context.l10n.phoneLabel,
                          controller: _phoneController,
                          validator: (v) =>
                              FormValidators.validatePhone(context, v),
                        ),
                        const SizedBox(height: 16),
                        ProfileTextField(
                          label: context.l10n.passwordLabel,
                          initialValue: "********",
                          isObscure: true,
                          readOnly: true,
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
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.primary,
                                    ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        GenderSelectionSection(selectedGender: _gender),
                        const SizedBox(height: 48),
                        state.editProfileState?.isLoading == true
                            ? const Center(child: CircularProgressIndicator())
                            : UpdateProfileButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    context.read<ProfileViewModel>().doIntent(
                                      EditProfileEvent(
                                        EditProfileRequest(
                                          firstName: _firstNameController.text,
                                          lastName: _lastNameController.text,
                                          email: _emailController.text,
                                          phone: _phoneController.text,
                                        ),
                                      ),
                                    );
                                  }
                                },
                              ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
