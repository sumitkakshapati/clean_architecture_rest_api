import 'package:flutter_clean_architecture_template/core/interface/use_case.dart';
import 'package:flutter_clean_architecture_template/core/services/user_services.dart';
import 'package:flutter_clean_architecture_template/features/splash/domain/entities/start_up_data.dart';

class FetchStartupDataInteractor extends AsyncUseCase<StartUpData, NoParam> {
  final UserServices userServices;

  FetchStartupDataInteractor({required this.userServices});

  @override
  Future<StartUpData> call(NoParam param) async {
    await userServices.initialize();
    return StartUpData(isLoggedIn: userServices.user.value != null);
  }
}
