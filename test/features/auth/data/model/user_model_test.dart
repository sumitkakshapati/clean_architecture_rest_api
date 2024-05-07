import 'package:flutter_clean_architecture_template/features/auth/data/models/user_model.dart';
import 'package:flutter_clean_architecture_template/features/auth/domain/entities/user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const userModel = UserModel(
    id: "1",
    firstName: "Sumit",
    lastName: "kakshapati",
    address: "Palpa",
  );

  test("Check User Model is subclass of User", () {
    expect(userModel, isA<User>());
  });
}
