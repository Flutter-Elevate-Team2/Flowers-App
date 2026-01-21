import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flowers_app/core/app_router/app_router.dart';
import 'package:flowers_app/core/di/di.dart';
import 'package:flowers_app/core/controller/session_controller.dart';
import 'package:flowers_app/core/l10n/app_localizations.dart';
import 'package:flowers_app/core/theming/app_theming.dart';
import 'package:flowers_app/core/helpers/session_expired_handler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flowers_app/Features/profile/presentation/view_model/profile_view_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'Features/order/presentation/view_model/cart_events.dart';
import 'Features/order/presentation/view_model/cart_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await configureDependencies();
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
      if (mounted) {
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
          create: (_) =>
          getIt<CartViewModel>()..doIntent(GetCartDataEvent()),
        ),
      BlocProvider(create: (context) => getIt<ProfileViewModel>())],
      child :
     MaterialApp.router(
      routerConfig: AppRouter.router,
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      theme: AppTheme.lightTheme,
     )
    );
  }
}
