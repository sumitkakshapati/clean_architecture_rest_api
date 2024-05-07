import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_template/core/pages/route_not_found_view.dart';
import 'package:flutter_clean_architecture_template/core/routes/routes.dart';
import 'package:flutter_clean_architecture_template/features/auth/presentation/pages/login_view.dart';
import 'package:flutter_clean_architecture_template/features/dashboard/presentation/pages/dashboard_view.dart';
import 'package:flutter_clean_architecture_template/features/splash/presentation/pages/splash_view.dart';
import 'package:page_transition/page_transition.dart';

class RouteGenerator {
  static Route<dynamic> routeGenerator(RouteSettings setting) {
    switch (setting.name) {
      case Routes.splash:
        return PageTransition(
          child: const SplashView(),
          type: PageTransitionType.fade,
        );
      case Routes.login:
        return PageTransition(
          child: const LoginView(),
          type: PageTransitionType.fade,
        );
      case Routes.dashboard:
        return PageTransition(
          child: const DashboardView(),
          type: PageTransitionType.fade,
        );
      default:
        return PageTransition(
          child: const RouteNotFoundView(),
          type: PageTransitionType.fade,
        );
    }
  }
}
