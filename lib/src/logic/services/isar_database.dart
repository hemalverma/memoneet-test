import 'package:infotexh_test/src/models/login_user.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../../models/user_model.dart';

class IsarDatabase {
  static late Isar isar;

  //create database

  static Future<void> initialize() async {
    //initialize database
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [UserModelSchema, LoginUserSchema],
      directory: dir.path,
    );
  }

  //write new user
  static Future<int> createUser(UserModel user) async {
    //write in database
    final res = await isar.writeTxn(() => isar.userModels.put(user));
    return res;
  }

  //check email exist or not
  static Future<UserModel?> checkEmailExistence(String email) async {
    //read from database
    final UserModel? user =
        await isar.userModels.where().filter().emailEqualTo(email).findFirst();
    return user;
  }

  //fetch by email and password
  static Future<UserModel?> fetchByEmailAndPass(
      String email, String pass) async {
    //read from database
    final UserModel? user = await isar.userModels
        .where()
        .filter()
        .emailEqualTo(email)
        .passwordEqualTo(pass)
        .findFirst();
    return user;
  }

  //fetch by id
  static Future<UserModel?> fetchById(int id) async {
    //read from database
    final UserModel? user =
        await isar.userModels.where().filter().idEqualTo(id).findFirst();
    return user;
  }

  //read all users
  static Future<List<UserModel>> fetchAllUser() async {
    //read from database
    final List<UserModel> user = await isar.userModels.where().findAll();
    return user;
  }

  //read all users
  static Future<bool> updateUser(int id, UserModel user) async {
    //read from database
    var u = await isar.userModels.get(id);
    u!.email = user.email;
    u.name = user.name;
    u.phone = user.phone;
    u.password = user.password;
    print('name ${user.name}');
    print('email ${user.email}');
    final res = await isar.writeTxn(() => isar.userModels.put(u));

    return true;
  }

  //delete user from db
  static Future<void> deleteUser(int id) async {
    //delete from database
    await isar.writeTxn(() => isar.userModels.delete(id));
  }
}
