import 'package:flutter_clean_architecture_template/features/auth/domain/entities/user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const Map<String, dynamic> userData = {
    "id": "1",
    "firstName": "Sumit",
    "lastName": "Kakshapati",
    "address": "Palpa",
  };

  const user = User(
    id: "1",
    firstName: "Sumit",
    lastName: "Kakshapati",
    address: "Palpa",
  );

  group("User", () {
    test(
      "Check Factory Method",
      () {
        final result = User.fromMap(userData);
        expect(result, user);
      },
    );

    test(
      "Check ToMaP Method",
      () {
        final result = user.toMap();
        expect(result, userData);
      },
    );
  });
}
