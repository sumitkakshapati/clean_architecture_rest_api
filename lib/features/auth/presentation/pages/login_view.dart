import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_template/core/injector/injection.dart';
import 'package:flutter_clean_architecture_template/features/auth/domain/usecases/login_interactor.dart';
import 'package:flutter_clean_architecture_template/features/auth/presentation/cubit/login_cubit.dart';
import 'package:flutter_clean_architecture_template/features/auth/presentation/widgets/login_body.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          LoginCubit(interactor: DI.instance<LoginInteractor>()),
      child: const LoginBody(),
    );
  }
}
