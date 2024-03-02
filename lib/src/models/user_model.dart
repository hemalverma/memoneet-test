import 'package:isar/isar.dart';

part 'user_model.g.dart';

@Collection()
class UserModel {
  Id id = Isar.autoIncrement;
  String? name;
  String? email;
  String? phone;
  String? password;
}
