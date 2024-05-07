import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_template/core/bloc/common_state.dart';
import 'package:flutter_clean_architecture_template/core/routes/routes.dart';
import 'package:flutter_clean_architecture_template/core/utils/size_utils.dart';
import 'package:flutter_clean_architecture_template/features/splash/domain/entities/start_up_data.dart';
import 'package:flutter_clean_architecture_template/features/splash/presentation/cubit/startup_cubit.dart';

class SplashBody extends StatelessWidget {
  const SplashBody({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    SizeUtils.init(context: context);
    return Scaffold(
      body: BlocListener<StartUpCubit, CommonState>(
        listener: (context, state) {
          if (state is CommonSuccessState<StartUpData>) {
            if (state.data?.isLoggedIn ?? false) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                Routes.dashboard,
                (_) => false,
              );
            } else {
              Navigator.of(context).pushNamedAndRemoveUntil(
                Routes.login,
                (_) => false,
              );
            }
          }
        },
        child: SizedBox(
          width: width,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlutterLogo(
                size: 150,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
