import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flowers_app/core/app_router/app_router.dart';
import 'package:flowers_app/core/di/di.dart';
import 'package:flowers_app/core/l10n/app_localizations.dart';
import 'package:flowers_app/core/theming/app_theming.dart';

class SessionExpiredHandler {
  static void handle(BuildContext? context) {
    final currentContext = context ?? AppRouter.rootNavigatorKey.currentState?.context;

    if (currentContext != null && currentContext.mounted) {
      final strings = AppLocalizations.of(currentContext)!;

      showDialog(
        context: currentContext,
        barrierDismissible: false,
        builder: (dialogContext) => AlertDialog(
          title: Text(strings.sessionExpiredTitle),
          content: Text(strings.sessionExpiredMessage),
          actions: [
            TextButton(
              onPressed: () async {
                final prefs = getIt<SharedPreferences>();
                await prefs.remove('token');

                if (dialogContext.mounted) {
                  Navigator.of(dialogContext).pop();
                }

                if (currentContext.mounted) {
                   GoRouter.of(currentContext).go(Routes.signInPath);
                }
              },
              child: Text(
                strings.loginButton,
                style: TextStyle(color: AppTheme.lightTheme.primaryColor),
              ),
            ),
          ],
        ),
      );
    } else {
      debugPrint("⚠️ Warning: Context is null or not mounted. Cannot show Session Expired Dialog.");
    }
  }
}
