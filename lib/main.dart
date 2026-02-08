import 'dart:async';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flowers_app/Features/notifications/presentation/view_model/notification_event.dart';
import 'package:flowers_app/Features/notifications/presentation/view_model/notification_view_model.dart';
import 'package:flowers_app/Features/profile/presentation/view_model/profile_view_model.dart';
import 'package:flowers_app/Features/user_address/presentation/view_model/user_address_event.dart';
import 'package:flowers_app/Features/user_address/presentation/view_model/user_address_view_model.dart';
import 'package:flowers_app/core/app_router/app_router.dart';
import 'package:flowers_app/core/controller/session_controller.dart';
import 'package:flowers_app/core/di/di.dart';
import 'package:flowers_app/core/helpers/session_expired_handler.dart';
import 'package:flowers_app/core/l10n/app_localizations.dart';
import 'package:flowers_app/core/l10n/view_model/language_cubit.dart';
import 'package:flowers_app/core/theming/app_theming.dart';
import 'package:flowers_app/core/widget/selected_address_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'Features/order/presentation/cart/view_model/cart_events.dart';
import 'Features/order/presentation/cart/view_model/cart_view_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load(fileName: ".env");
  await configureDependencies();

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _sessionController = getIt<SessionController>();
  late StreamSubscription? _subscription;
  @override
  void initState() {
    super.initState();
    _subscription = _sessionController.onSessionExpired.listen((_) {
      // Fix: Check mounted and pass correct context
      final context = AppRouter.rootNavigatorKey.currentContext;
      if (context != null && mounted) {
        SessionExpiredHandler.handle(context);
      }
    });
  }

  @override
  void dispose() {
    // Fix: Safe cancel
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CartViewModel>(
          create: (_) => getIt<CartViewModel>()..doIntent(GetCartDataEvent()),
        ),
        BlocProvider(create: (_) => LanguageCubit()),
        BlocProvider(create: (context) => getIt<ProfileViewModel>()),
        BlocProvider(
          create: (context) =>
              getIt<UserAddressViewModel>()..doIntent(GetAddressesEvent()),
        ),
        BlocProvider(create: (_) => SelectedAddressCubit()),
        BlocProvider(
          create: (context) =>
              getIt<NotificationViewModel>()..doIntent(GetNotificationsEvent()),
        ),
      ],
      child: BlocBuilder<LanguageCubit, Locale>(
        builder: (context, locale) {
          return MaterialApp.router(
            locale: locale,
            routerConfig: AppRouter.router,
            debugShowCheckedModeBanner: false,
            onGenerateTitle: (context) =>
                AppLocalizations.of(context)!.appTitle,
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            theme: AppTheme.lightTheme,
          );
        },
      ),
    );
  }
}
