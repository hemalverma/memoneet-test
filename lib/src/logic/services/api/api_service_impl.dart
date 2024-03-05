import 'package:firebase_auth/firebase_auth.dart';
import 'package:memoneet_test/src/logic/services/firestore_service.dart';
import 'package:memoneet_test/src/models/note_model.dart';
import 'package:memoneet_test/src/models/response/api_response.dart';
import 'package:memoneet_test/src/models/user_model.dart';

import '../firebase_auth_provider.dart';
import 'api_service.dart';

class ApiServiceImpl extends ApiService {
  @override
  Future<ApiResponse<UserCredential>> createUser(
      {required UserModel user}) async {
    try {
      final response = await FirebaseService.createUser(user);
      if (response.status == ApiStatus.success) {
        if (response.data == null) {
          return ApiResponse<UserCredential>.error('Registration Failed');
        }
        return ApiResponse<UserCredential>.success(response.data!);
      }
      return ApiResponse<UserCredential>.error(response.errorMessage);
    } catch (e) {
      return ApiResponse<UserCredential>.error(e.toString());
    }
  }

  @override
  Future<ApiResponse<UserModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await FirebaseService.login(email, password);
      if (response.status == ApiStatus.success) {
        if (response.data == null) {
          return ApiResponse<UserModel>.error('User Does not Exist');
        }
        return ApiResponse<UserModel>.success(UserModel()
          ..email = response.data!.email!
          ..id = response.data!.uid
          ..name = response.data!.displayName);
      }
      return ApiResponse<UserModel>.error(response.errorMessage);
    } catch (e) {
      return ApiResponse<UserModel>.error(e.toString());
    }
  }

  @override
  Future<ApiResponse<List<UserModel>?>> fetchAllUsers() async {
    try {
      return ApiResponse<List<UserModel>>.error('No Users Found');
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
      return ApiResponse<bool>.error('Failed to Update');
    } catch (e) {
      return ApiResponse<bool>.error(e.toString());
    }
  }

  @override
  Future<ApiResponse<List<NoteModel>>> fetchAllNotes() async {
    try {
      //call graphql api

      final res = await FireStoreService.getAllDocuments(collection: 'Notes');
      if (res != null) {
        final notes = res
            .map((e) =>
                NoteModel.fromJson(e.data() as Map<String, dynamic>, e.id))
            .toList();
        return ApiResponse<List<NoteModel>>.success(notes);
      }
      return ApiResponse<List<NoteModel>>.error('error');
    } catch (e) {
      return ApiResponse<List<NoteModel>>.error(e.toString());
    }
  }

  @override
  Future<ApiResponse<bool>> addNote({
    required NoteModel noteModel,
  }) async {
    try {
      //call graphql api

      final res = await FireStoreService.setData(
          path: 'Notes/', data: noteModel.toJson());
      return ApiResponse<bool>.success(true);
    } catch (e) {
      return ApiResponse<bool>.error(e.toString());
    }
  }

  @override
  Future<ApiResponse<bool>> deleteNote({
    required String id,
  }) async {
    try {
      //call graphql api
      await FireStoreService.deleteData(id: id);
      return ApiResponse<bool>.success(true);
    } catch (e) {
      return ApiResponse<bool>.error(e.toString());
    }
  }

  @override
  Future<ApiResponse<bool>> updateNote({
    required NoteModel noteModel,
    required noteId,
  }) async {
    try {
      //call firebase api
      await FireStoreService.updateData(id: noteId, data: noteModel.toJson());
      return ApiResponse<bool>.success(true);
    } catch (e) {
      return ApiResponse<bool>.error(e.toString());
    }
  }
}
