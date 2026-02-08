import 'package:flowers_app/core/app_router/app_router.dart';
import 'package:flowers_app/core/constants/api_constants.dart';
import 'package:flowers_app/core/di/di.dart';
import 'package:flowers_app/core/l10n/app_localizations.dart';
import 'package:flowers_app/core/theming/app_theming.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionExpiredHandler {
  static bool _isShowing = false;

  static void handle(BuildContext? context) {
    if (_isShowing) return;

    final currentContext =
        context ?? AppRouter.rootNavigatorKey.currentState?.context;

    if (currentContext != null && currentContext.mounted) {
      _isShowing = true;

      final localizations = AppLocalizations.of(currentContext);

      final title = localizations?.sessionExpiredTitle ?? "Session Expired";
      final message = localizations?.sessionExpiredMessage ?? "Your session has expired. Please login again.";
      final loginButtonText = localizations?.loginButton ?? "Login";

      showDialog(
        context: currentContext,
        barrierDismissible: false,
        builder: (dialogContext) => AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () async {
                final prefs = getIt<SharedPreferences>();
                await prefs.remove(ApiConstants.tokenKey);

                if (dialogContext.mounted) {
                  Navigator.of(dialogContext).pop();
                }

                if (currentContext.mounted) {
                  while (currentContext.canPop()) {
                    currentContext.pop();
                  }
                  GoRouter.of(currentContext).go(Routes.signInPath);
                }
              },
              child: Text(
                loginButtonText,
                style: TextStyle(color: AppTheme.lightTheme.primaryColor),
              ),
            ),
          ],
        ),
      ).then((_) => _isShowing = false);
    } else {
      debugPrint(
        "⚠️ Warning: Context is null or not mounted. Cannot show Session Expired Dialog.",
      );
    }
  }
}
