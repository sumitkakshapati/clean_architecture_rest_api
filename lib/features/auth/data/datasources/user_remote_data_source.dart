import 'package:flutter_clean_architecture_template/features/auth/data/models/user_model.dart';
import 'package:flutter_clean_architecture_template/features/auth/domain/entities/param/login_param.dart';

abstract class UserRemoteDataSource {
  Future<UserModel> login(LoginParam param);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  @override
  Future<UserModel> login(LoginParam param) async {
    await Future.delayed(const Duration(seconds: 2));
    return const UserModel(
      id: "1",
      firstName: "Sumit",
      lastName: "Kakshapati",
      address: "Palpa",
    );
  }
}
