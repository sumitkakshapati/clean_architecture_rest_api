import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_template/core/database/database_service.dart';
import 'package:flutter_clean_architecture_template/features/auth/domain/entities/user.dart';

class UserServices {
  final DatabaseService databaseService;

  UserServices({
    required this.databaseService,
  });

  // ---------------------- User ----------------------
  final ValueNotifier<User?> _user = ValueNotifier(null);

  ValueNotifier<User?> get user => _user;

  Future<void> initialize() async {
    final tempUser = await databaseService.getUser();
    _user.value = tempUser;
  }

  Future<void> saveUser(User user) async {
    await databaseService.saveUser(user);
    _user.value = user;
  }

  Future<void> removeUser() async {
    _user.value = null;
    await databaseService.removeUser();
  }
}
