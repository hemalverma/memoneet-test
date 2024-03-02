import 'package:infotexh_test/src/models/response/api_response.dart';
import 'package:infotexh_test/src/models/user_model.dart';

import '../isar_database.dart';
import 'api_service.dart';

class ApiServiceImpl extends ApiService {
  @override
  Future<ApiResponse<UserModel>> createUser({required UserModel user}) async {
    try {
      final res = await IsarDatabase.checkEmailExistence(user.email!);
      if (res != null) {
        return ApiResponse<UserModel>.error('Email already exist');
      }
      final result = await IsarDatabase.createUser(user);
      if (result == 0) {
        return ApiResponse<UserModel>.error('User not created');
      }
      return ApiResponse.success(user..id = result);
    } catch (e) {
      return ApiResponse<UserModel>.error(e.toString());
    }
  }

  @override
  Future<ApiResponse<UserModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      final res = await IsarDatabase.fetchByEmailAndPass(email, password);
      if (res == null) {
        return ApiResponse<UserModel>.error('User Does not Exist');
      }
      return ApiResponse.success(res);
    } catch (e) {
      return ApiResponse<UserModel>.error(e.toString());
    }
  }

  @override
  Future<ApiResponse<List<UserModel>?>> fetchAllUsers() async {
    try {
      final res = await IsarDatabase.fetchAllUser();
      if (res.isEmpty) {
        return ApiResponse<List<UserModel>>.error('No Users Found');
      }
      return ApiResponse.success(res);
    } catch (e) {
      return ApiResponse<List<UserModel>>.error(e.toString());
    }
  }

  @override
  Future<ApiResponse<bool>> updateUser({
    required int userId,
    required UserModel userModel,
  }) async {
    try {
      final res = await IsarDatabase.updateUser(userId, userModel);
      if (!res) {
        return ApiResponse<bool>.error('Failed to Update');
      }
      return ApiResponse.success(true);
    } catch (e) {
      return ApiResponse<bool>.error(e.toString());
    }
  }
}
