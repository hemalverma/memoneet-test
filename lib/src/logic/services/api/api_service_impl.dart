import 'package:infotexh_test/src/logic/services/api/graphql_service.dart';
import 'package:infotexh_test/src/models/episode_data_model.dart';
import 'package:infotexh_test/src/models/response/api_response.dart';
import 'package:infotexh_test/src/models/user_model.dart';

import '../graph_ql/qrapg_ql_raw.dart';
import '../isar_database.dart';
import 'api_service.dart';

class ApiServiceImpl extends ApiService {
  final GraphQlService _graphQlService = GraphQlService();
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

  @override
  Future<ApiResponse<List<SingleEpisode>>> fetchAllEpisodes() async {
    try {
      //call graphql api
      final result = await _graphQlService.performQuery(
        GraphQlRaw.getEpisodeQuery,
        variables: {},
      );
      if (result.hasException) {
        return ApiResponse<List<SingleEpisode>>.error(
            result.exception.toString());
      }
      if (result.data == null) {
        return ApiResponse<List<SingleEpisode>>.error('No Episodes Found');
      }

      final List<SingleEpisode> episodes =
          (result.data!['episodes']['results'] as List)
              .map((e) => SingleEpisode.fromJson(e))
              .toList();

      return ApiResponse<List<SingleEpisode>>.success(episodes);
    } catch (e) {
      return ApiResponse<List<SingleEpisode>>.error(e.toString());
    }
  }
}
