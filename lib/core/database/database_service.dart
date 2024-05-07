import 'package:flutter_clean_architecture_template/features/auth/domain/entities/user.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DatabaseService {
  final String _boxName = "test";
  final String _user = "user";

  static Box? _box;

  static void init() async {
    await Hive.initFlutter();
  }

  static void dispose() async {
    _box?.close();
  }

  Future<Box> get getHiveBox async {
    if (_box?.isOpen != true) {
      _box = await Hive.openBox(_boxName);
    }
    return _box!;
  }

  Future<void> saveUser(User user) async {
    final Box box = await getHiveBox;
    await box.put(_user, user.toMap());
  }

  Future<User?> getUser() async {
    final Box box = await getHiveBox;
    final res = await box.get(_user);
    if (res != null) {
      return User.fromMap(Map<String, dynamic>.from(res));
    } else {
      return null;
    }
  }

  Future<void> removeUser() async {
    final Box box = await getHiveBox;
    await box.delete(_user);
  }
}
