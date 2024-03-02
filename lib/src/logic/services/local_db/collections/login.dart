import 'package:infotexh_test/src/logic/services/isar_database.dart';
import 'package:infotexh_test/src/models/login_user.dart';
import 'package:isar/isar.dart';

class LoginCollection {
  static Future<LoginUser?> isLoggedInSession() async {
    final res = await IsarDatabase.isar.loginUsers
        .where()
        .filter()
        .isLoggedInEqualTo(true)
        .findFirst();
    return res;
  }

  static Future<bool> saveLoggedInSession(int userId) async {
    final LoginUser user = LoginUser()
      ..userId = userId
      ..isLoggedIn = true;
    final res = await IsarDatabase.isar
        .writeTxn(() => IsarDatabase.isar.loginUsers.put(user));
    if (res != 0) {
      return true;
    }
    return false;
  }

  static Future<bool> clearLoggedInSession() async {
    final res = await IsarDatabase.isar
        .writeTxn(() => IsarDatabase.isar.loginUsers.clear());
    return true;
  }
}
