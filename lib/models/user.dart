
import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 1)
class User {
  @HiveField(0)
  final String userName;
  @HiveField(1)
  final String password;

  const User(
    this.userName,
    this.password,
  );
}
