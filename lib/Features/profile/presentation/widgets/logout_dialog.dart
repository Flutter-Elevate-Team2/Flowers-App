import 'package:flowers_app/Features/profile/presentation/view_model/profile_event.dart';
import 'package:flowers_app/Features/profile/presentation/view_model/profile_state.dart';
import 'package:flowers_app/Features/profile/presentation/view_model/profile_view_model.dart';
import 'package:flowers_app/core/app_router/app_router.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileViewModel, ProfileState>(
      listenWhen: (previous, current) =>
          previous.logoutState != current.logoutState &&
          current.logoutState != null,
      listener: (context, state) {
        final logoutState = state.logoutState;
        if (logoutState != null && logoutState.isLoading == false) {
          if (logoutState.errorMessage != null) {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(logoutState.errorMessage!),
                backgroundColor: Colors.red,
              ),
            );
          } else {
            Navigator.of(context).pop();
            context.goNamed(Routes.signInName);
          }
        }
      },
      child: BlocBuilder<ProfileViewModel, ProfileState>(
        buildWhen: (previous, current) =>
            previous.logoutState != current.logoutState,
        builder: (context, state) {
          final isLoading = state.logoutState?.isLoading ?? false;
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            backgroundColor: Theme.of(context).colorScheme.surface,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    context.l10n.logoutTitle,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    context.l10n.confirmLogout,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: isLoading
                              ? null
                              : () {
                                  Navigator.of(context).pop();
                                },
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              color: Theme.of(
                                context,
                              ).colorScheme.surfaceContainerHighest,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: Text(
                            context.l10n.cancel,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.secondary,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: isLoading
                              ? null
                              : () {
                                  context.read<ProfileViewModel>().doIntent(
                                    LogoutEvent(),
                                  );
                                },
                          style: ElevatedButton.styleFrom(elevation: 0),
                          child: isLoading
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : Text(context.l10n.logout),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
