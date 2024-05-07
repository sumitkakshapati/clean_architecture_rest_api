import 'dart:io';

import 'package:dartz_test/dartz_test.dart';
import 'package:flutter_clean_architecture_template/core/services/user_services.dart';
import 'package:flutter_clean_architecture_template/features/auth/domain/entities/param/login_param.dart';
import 'package:flutter_clean_architecture_template/features/auth/domain/entities/user.dart';
import 'package:flutter_clean_architecture_template/features/auth/domain/repositories/user_repository.dart';
import 'package:flutter_clean_architecture_template/features/auth/domain/usecases/login_interactor.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_interactor_test.mocks.dart';

@GenerateMocks([UserRepository, UserServices])
void main() {
  late UserRepository userRepository;
  late UserServices userServices;
  late LoginInteractor loginInteractor;

  const LoginParam loginParam =
      LoginParam(email: "sumit@gmail.com", password: "password");

  const User user = User(
    id: "id",
    firstName: "Sumit",
    lastName: "Kakshapati",
    address: "kathmandu",
  );

  setUp(() {
    userRepository = MockUserRepository();
    userServices = MockUserServices();
    loginInteractor = LoginInteractor(
        userRepository: userRepository, userServices: userServices);
  });

  test("Login", () async {
    //Arrage
    when(userRepository.login(loginParam)).thenAnswer((_) async => user);

    when(userServices.saveUser(user));

    //Act

    final result = await loginInteractor(loginParam);

    //Assets
    expect(result, isRightThat(user));
  });

  test("Login Failure Case", () async {
    //Arrage
    when(userRepository.login(loginParam))
        .thenThrow(const SocketException("Internet connection"));

    // when(userServices.saveUser(user));

    //Act
    final result = await loginInteractor(loginParam);

    //Assets
    expect(result, isLeftThat(isA<String>()));
  });
}
