import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:memoneet_test/src/models/note_model.dart';
import 'package:memoneet_test/src/models/response/api_response.dart';

import '../../logic/services/api/api_service.dart';

part 'home_page_model.freezed.dart';

//provider
final homePageModelProvider =
    StateNotifierProvider<HomePageModel, HomePageState>(
  (ref) => HomePageModel(
    apiService: ref.watch(apiServiceProvider),
    ref: ref,
  ),
);

//view_model
class HomePageModel extends StateNotifier<HomePageState> {
  final ApiService apiService;
  StateNotifierProviderRef ref;
  HomePageModel({
    required this.apiService,
    required this.ref,
  }) : super(const HomePageState());

  fetchAllNotes() async {
    state = state.copyWith(status: HomeStatus.loading);
    //api call
    try {
      final response = await apiService.fetchAllNotes();
      if (response.status != ApiStatus.success) {
        setError(response.errorMessage ?? 'Failed to get Note Data');
        return;
      }
      if (response.data == null) {
        setError('Failed to get Note Data');
        return;
      }
      //login success
      state = state.copyWith(status: HomeStatus.loaded, notes: response.data!);
    } catch (e) {
      setError(e.toString());
      return;
    }
  }

  addNote(NoteModel note) async {
    state = state.copyWith(addNoteStatus: AddNoteStatus.loading);
    //api call
    try {
      final response = await apiService.addNote(noteModel: note);
      if (response.status != ApiStatus.success) {
        setAddNoteError(response.errorMessage ?? 'Failed to get Note Data');
        return;
      }
      if (response.data == null) {
        setAddNoteError('Failed to get Note Data');
        return;
      }
      //login success
      state = state.copyWith(addNoteStatus: AddNoteStatus.loaded);
      fetchAllNotes();
    } catch (e) {
      setAddNoteError(e.toString());
      return;
    }
  }

  updateNote(NoteModel note) async {
    state = state.copyWith(updateNoteStatus: UpdateNoteStatus.loading);
    if (note.id == null) {
      setUpdateNoteError('Note Id is null');
      return;
    }
    //api call
    try {
      final response =
          await apiService.updateNote(noteModel: note, noteId: note.id!);
      if (response.status != ApiStatus.success) {
        setUpdateNoteError(response.errorMessage ?? 'Failed to get Note Data');
        return;
      }
      if (response.data == null) {
        setUpdateNoteError('Failed to get Note Data');
        return;
      }
      //login success
      state = state.copyWith(updateNoteStatus: UpdateNoteStatus.loaded);
      fetchAllNotes();
    } catch (e) {
      setUpdateNoteError(e.toString());
      return;
    }
  }

  deleteNote(NoteModel note) async {
    state = state.copyWith(
      deleteNoteStatus: DeleteNoteStatus.loading,
      deletingNoteId: note.id,
    );
    if (note.id == null) {
      setDeleteNoteError('Note Id is null');
      return;
    }
    //api call
    try {
      final response = await apiService.deleteNote(id: note.id!);
      if (response.status != ApiStatus.success) {
        setDeleteNoteError(response.errorMessage ?? 'Failed to get Note Data');
        return;
      }
      if (response.data == null) {
        setDeleteNoteError('Failed to get Note Data');
        return;
      }
      //note deleted
      state = state.copyWith(
          deleteNoteStatus: DeleteNoteStatus.loaded, deletingNoteId: null);
      fetchAllNotes();
    } catch (e) {
      setDeleteNoteError(e.toString());
      return;
    }
  }

  setError(String error) {
    state = state.copyWith(
      errorMessage: error,
      status: HomeStatus.error,
    );
  }

  setAddNoteError(String error) {
    state = state.copyWith(
      addNoteErrorMessage: error,
      addNoteStatus: AddNoteStatus.error,
    );
  }

  setDeleteNoteError(String error) {
    state = state.copyWith(
      deletingNoteId: null,
      deleteNoteErrorMessage: error,
      deleteNoteStatus: DeleteNoteStatus.error,
    );
  }

  setUpdateNoteError(String error) {
    state = state.copyWith(
      updateNoteErrorMessage: error,
      updateNoteStatus: UpdateNoteStatus.error,
    );
  }
}

//state
@freezed
class HomePageState with _$HomePageState {
  const factory HomePageState({
    List<NoteModel>? notes,
    @Default(HomeStatus.loading) HomeStatus status,
    String? errorMessage,
    @Default(AddNoteStatus.initial) AddNoteStatus addNoteStatus,
    String? addNoteErrorMessage,
    String? deletingNoteId,
    @Default(DeleteNoteStatus.initial) DeleteNoteStatus deleteNoteStatus,
    String? deleteNoteErrorMessage,
    @Default(UpdateNoteStatus.initial) UpdateNoteStatus updateNoteStatus,
    String? updateNoteErrorMessage,
  }) = _HomePageState;
}

enum HomeStatus {
  loading,
  loaded,
  error,
}

enum AddNoteStatus {
  initial,
  loading,
  loaded,
  error,
}

enum DeleteNoteStatus {
  initial,
  loading,
  loaded,
  error,
}

enum UpdateNoteStatus {
  initial,
  loading,
  loaded,
  error,
}
