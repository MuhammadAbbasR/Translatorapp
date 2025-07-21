import 'package:camera_ocr_scanner/CameraScreen.dart';
import 'package:camera_ocr_scanner/routes/Route_Name.dart';
import 'package:camera_ocr_scanner/ui/HomePage.dart';
import 'package:camera_ocr_scanner/ui/Login.dart';
import 'package:camera_ocr_scanner/ui/SIgnup.dart';
import 'package:camera_ocr_scanner/ui/Splash_Screen.dart';
import 'package:camera_ocr_scanner/ui/forgetpassword.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static final GlobalKey<NavigatorState> _routeNavigatorState =
      GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
      navigatorKey: _routeNavigatorState,
      initialLocation: RoutesName.splash_route,
      routes: <RouteBase>[
        GoRoute(
          path: RoutesName.splash_route,
          builder: (BuildContext context, GoRouterState state) {
            return SplashScreen();
          },
        ),
        GoRoute(
          path: RoutesName.home_route,
          builder: (BuildContext context, GoRouterState state) {
            return HomePage();
          },
        ),
        GoRoute(
          path: RoutesName.login_route,
          builder: (BuildContext context, GoRouterState state) {
            return LoginPage();
          },
        ),
        GoRoute(
          path: RoutesName.signup_route,
          builder: (BuildContext context, GoRouterState state) {
            return SignupPage();
          },
        ),
        GoRoute(
          path: '/camera',
          builder: (BuildContext context, GoRouterState state) {
            return Camerascreen();
          },
        ),
        GoRoute(
          path: RoutesName.forgetpass,
          builder: (BuildContext context, GoRouterState state) {
            return ForgotPasswordPage();
          },
        ),
      ]);
}
