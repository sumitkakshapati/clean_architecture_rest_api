import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_template/core/bloc/common_state.dart';
import 'package:flutter_clean_architecture_template/core/interface/use_case.dart';
import 'package:flutter_clean_architecture_template/features/splash/domain/entities/start_up_data.dart';
import 'package:flutter_clean_architecture_template/features/splash/domain/usecases/fetch_start_up_data.dart';

class StartUpCubit extends Cubit<CommonState> {
  FetchStartupDataInteractor interactor;
  StartUpCubit({required this.interactor}) : super(CommonInitialState());

  fetchData() async {
    emit(CommonLoadingState());
    await Future.delayed(const Duration(seconds: 2));
    final data = await interactor(NoParam());
    emit(CommonSuccessState<StartUpData>(data: data));
  }
}
