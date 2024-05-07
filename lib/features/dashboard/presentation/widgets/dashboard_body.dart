import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_template/core/constants/locale_keys.dart';
import 'package:flutter_clean_architecture_template/core/injector/injection.dart';
import 'package:flutter_clean_architecture_template/core/routes/routes.dart';
import 'package:flutter_clean_architecture_template/core/services/user_services.dart';
import 'package:flutter_clean_architecture_template/core/utils/snackbar_utils.dart';

class DashboardBody extends StatelessWidget {
  const DashboardBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              DI.instance<UserServices>().removeUser();
              SnackBarUtils.showErrorMessage(
                context: context,
                message: LocaleKeys.loggedOutSuccessfully.tr(),
              );
              Navigator.of(context).pushNamedAndRemoveUntil(
                Routes.login,
                (route) => false,
              );
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: const Center(
        child: Text("Dashboard"),
      ),
    );
  }
}
