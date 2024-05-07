import 'package:flutter_clean_architecture_template/features/auth/data/datasources/user_remote_data_source.dart';
import 'package:flutter_clean_architecture_template/features/auth/data/models/user_model.dart';
import 'package:flutter_clean_architecture_template/features/auth/data/repositories/user_repository_impl.dart';
import 'package:flutter_clean_architecture_template/features/auth/domain/entities/param/login_param.dart';
import 'package:flutter_clean_architecture_template/features/auth/domain/repositories/user_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'user_repository_test.mocks.dart';

@GenerateMocks([UserRemoteDataSource])
void main() {
  late UserRemoteDataSource remoteSource;
  late UserRepository userRepository;

  const LoginParam loginParam = LoginParam(
    email: "sumit@gmail.com",
    password: "password",
  );

  const user = UserModel(
    id: "1",
    firstName: "Sumit",
    lastName: "kakshapati",
    address: "Palpa",
  );

  setUp(() {
    remoteSource = MockUserRemoteDataSource();
    userRepository = UserRepositoryImpl(remoteDataSource: remoteSource);
  });

  group("Login Test", () {
    test(
      "Login",
      () async {
        // Arrange
        when(remoteSource.login(loginParam)).thenAnswer((_) async => user);

        //Act
        final result = await userRepository.login(loginParam);

        //Assert
        expect(result, user);
      },
    );
  });
}
