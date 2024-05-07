import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String address;

  const User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.address,
  });

  @override
  List<Object?> get props => [id, firstName, lastName, address];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'address': address,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      address: map['address'] as String,
    );
  }
}
