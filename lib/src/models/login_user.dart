import 'package:isar/isar.dart';

part 'login_user.g.dart';

@Collection()
class LoginUser {
  Id id = Isar.autoIncrement;
  bool isLoggedIn = false;
  int? userId;
}
