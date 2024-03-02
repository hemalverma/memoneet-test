import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infotexh_test/src/models/user_model.dart';

import '../../../models/response/api_response.dart';
import 'api_service_impl.dart';

final apiServiceProvider = Provider<ApiService>(
  (ref) => ApiServiceImpl(),
);

abstract class ApiService {
  Future<ApiResponse<UserModel>> createUser({
    required UserModel user,
  });
  Future<ApiResponse<UserModel>> login({
    required String email,
    required String password,
  });

  Future<ApiResponse<List<UserModel>?>> fetchAllUsers();

  Future<ApiResponse<bool>> updateUser({
    required int userId,
    required UserModel userModel,
  });
}
