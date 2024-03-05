import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:memoneet_test/src/models/note_model.dart';
import 'package:memoneet_test/src/models/user_model.dart';

import '../../../models/response/api_response.dart';
import 'api_service_impl.dart';

final apiServiceProvider = Provider<ApiService>(
  (ref) => ApiServiceImpl(),
);

abstract class ApiService {
  Future<ApiResponse<UserCredential>> createUser({
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

  Future<ApiResponse<List<NoteModel>>> fetchAllNotes();

  Future<ApiResponse<bool>> addNote({
    required NoteModel noteModel,
  });
  Future<ApiResponse<bool>> deleteNote({
    required String id,
  });

  Future<ApiResponse<bool>> updateNote({
    required NoteModel noteModel,
    required noteId,
  });
}
