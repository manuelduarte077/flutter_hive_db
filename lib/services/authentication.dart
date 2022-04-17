import 'package:flutter_hive_db/models/models.dart';
import 'package:hive/hive.dart';

class AuthenticationService {
  late Box<User> _users;

  Future<void> init() async {
    Hive.registerAdapter(UserAdapter());
    _users = await Hive.openBox<User>('usersBox');
  }

  Future<String?> authenticateUser(
      final String userName, final String password) async {
    final success = _users.values.any((element) =>
        element.userName == userName && element.password == password);

    if (success) {
      return userName;
    } else {
      return null;
    }
  }
}
