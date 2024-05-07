import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_template/app/env.dart';
import 'package:flutter_clean_architecture_template/core/constants/locale_keys.dart';
import 'package:flutter_clean_architecture_template/core/database/database_service.dart';
import 'package:flutter_clean_architecture_template/core/injector/injection.dart';
import 'package:flutter_clean_architecture_template/core/routes/route_generator.dart';
import 'package:flutter_clean_architecture_template/core/routes/routes.dart';
import 'package:flutter_clean_architecture_template/core/services/navigation_services.dart';
import 'package:flutter_clean_architecture_template/core/theme/custom_theme.dart';
import 'package:flutter_clean_architecture_template/core/wrapper/localization_wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await DI.init(env: Env.development());
  DatabaseService.init();
  runApp(
    const LocalizationWrapper(
      child: MyAppDevelopment(),
    ),
  );
}

class MyAppDevelopment extends StatefulWidget {
  const MyAppDevelopment({super.key});

  @override
  State<MyAppDevelopment> createState() => _MyAppDevelopmentState();
}

class _MyAppDevelopmentState extends State<MyAppDevelopment> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(NavigationService.context).unfocus();
      },
      child: MaterialApp(
        title: LocaleKeys.appName.tr(),
        theme: CustomTheme.lightTheme,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        navigatorKey: NavigationService.navigationKey,
        onGenerateRoute: RouteGenerator.routeGenerator,
        initialRoute: Routes.splash,
      ),
    );
  }

  @override
  void dispose() {
    DatabaseService.dispose();
    super.dispose();
  }
}
