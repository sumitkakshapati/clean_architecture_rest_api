// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_clean_architecture_template/features/auth/data/datasources/user_remote_data_source.dart';
import 'package:flutter_clean_architecture_template/features/auth/domain/entities/param/login_param.dart';
import 'package:flutter_clean_architecture_template/features/auth/domain/entities/user.dart';
import 'package:flutter_clean_architecture_template/features/auth/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<User> login(LoginParam param) async {
    return await remoteDataSource.login(param);
  }
}
