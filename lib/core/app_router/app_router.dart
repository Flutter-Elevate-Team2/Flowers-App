

import 'package:go_router/go_router.dart';

/// ====== Define all routes and route names ======
class Routes {
  static const String loginPath = '/login';
    static const String loginName = 'login';

  static const String signupPath = '/signup';
    static const String signupName = 'signup';

  static const String forgetPasswordPath = '/forget-password-flow';
  static const String forgetPasswordName = 'forgetPassword';
  
  static const String homePath = '/home';
  static const String homeName = 'home';


}

/// ====== Main App Router ======
class AppRouter {
  static final GoRouter router = GoRouter(
    
   
    routes: [
      /// ====== LOGIN SCREEN ======
      GoRoute(
        path: Routes.loginPath,
        name: Routes.loginName,
      //  builder: (context, state) => LoginScreen(),
      ),

      /// ====== SIGN UP SCREEN ======
      GoRoute(
        path: Routes.signupPath,
        name: Routes.signupName,
      //  builder: (context, state) => SignupScreen(),
      ),
      /// ====== FORGET PASSWORD FLOW ======
          GoRoute(
            path: Routes.forgetPasswordPath,
            name: Routes.forgetPasswordName,
          //  builder: (context, state) => ForgetPasswordScreen(),
          ),
      /// ====== HOME SCREEN ======
      GoRoute(
        path: Routes.homePath,
        name: Routes.homeName,
      //  builder: (context, state) => HomeScreen(),
      ),
    ],
  );
}