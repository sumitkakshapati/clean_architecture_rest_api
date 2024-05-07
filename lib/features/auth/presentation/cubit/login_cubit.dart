import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_template/core/bloc/common_state.dart';
import 'package:flutter_clean_architecture_template/features/auth/domain/entities/param/login_param.dart';
import 'package:flutter_clean_architecture_template/features/auth/domain/entities/user.dart';
import 'package:flutter_clean_architecture_template/features/auth/domain/usecases/login_interactor.dart';

class LoginCubit extends Cubit<CommonState> {
  final LoginInteractor interactor;

  LoginCubit({required this.interactor}) : super(CommonInitialState());

  login(LoginParam param) async {
    emit(CommonLoadingState());
    final res = await interactor(param);
    res.fold(
      (err) => emit(CommonErrorState(message: err)),
      (data) => emit(CommonSuccessState<User>(data: data)),
    );
  }
}
