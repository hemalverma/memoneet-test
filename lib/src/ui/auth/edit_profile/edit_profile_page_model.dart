import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infotexh_test/src/logic/repo/app_repository.dart';
import 'package:infotexh_test/src/models/response/api_response.dart';
import 'package:infotexh_test/src/models/user_model.dart';

import '../../../logic/services/api/api_service.dart';
import '../../../logic/services/isar_database.dart';

part 'edit_profile_page_model.freezed.dart';

//provider
final editProfilePageModelProvider =
    StateNotifierProvider<EditProfilePageModel, EditProfilePageState>(
  (ref) => EditProfilePageModel(
    apiService: ref.watch(apiServiceProvider),
    ref: ref,
  ),
);

//view_model
class EditProfilePageModel extends StateNotifier<EditProfilePageState> {
  final ApiService apiService;
  StateNotifierProviderRef ref;
  EditProfilePageModel({
    required this.apiService,
    required this.ref,
  }) : super(const EditProfilePageState());

  fetchMyProfile() async {
    final uid =
        ref.read(appRepositoryProvider.select((value) => value.userModel));
    if (uid != null) {
      final user = await IsarDatabase.fetchById(uid.id);
      if (user != null) {
        state = state.copyWith(
          user: user,
          name: user.name,
          email: user.email,
          phone: user.phone,
          password: user.password,
          fetchStatus: FetchStatus.loaded,
        );
      }
    }
  }

  validateAndRegister() {
    state = state.copyWith(saveStatus: SaveStatus.loading);
    if (state.name == null || state.name == '') {
      setError('Name can\'t be empty', ErrorField.name);
      return;
    }

    if (state.email == null || state.email == '') {
      setError('Email can\'t be empty', ErrorField.email);
      return;
    }
    if (state.phone == null) {
      setError('Phone can\'t be empty', ErrorField.phone);
      return;
    }
    if (state.phone!.length != 10) {
      setError('Phone length must be 10', ErrorField.phone);
      return;
    }

    if (state.password == null) {
      setError('Password is must', ErrorField.password);
      return;
    }

    if (state.password!.length < 6) {
      setError('Password is too short', ErrorField.password);
      return;
    } else {
      editUser();
    }
  }

  editUser() async {
    final uid =
        ref.read(appRepositoryProvider.select((value) => value.userModel));
    if (uid != null) {
      final user = UserModel()
        ..id = uid.id
        ..name = state.name
        ..email = state.email
        ..phone = state.phone
        ..password = state.password;
      final res = await apiService.updateUser(userId: uid.id, userModel: user);

      if (res.status != ApiStatus.success) {
        state = state.copyWith(
          saveStatus: SaveStatus.error,
          errorMessage: res.errorMessage ?? 'Error Occurred',
        );
      } else {
        state = state.copyWith(
          saveStatus: SaveStatus.loaded,
        );
      }
    } else {
      state = state.copyWith(
        saveStatus: SaveStatus.error,
        errorMessage: 'Error Occurred user null',
      );
    }
  }

  setName(String name) {
    state = state.copyWith(name: name);
  }

  setNameError(bool error) {
    state = state.copyWith(nameError: error);
  }

  setEmail(String email) {
    state = state.copyWith(email: email);
  }

  setEmailError(bool error) {
    state = state.copyWith(emailError: error);
  }

  setPassword(String password) {
    state = state.copyWith(password: password);
  }

  setPasswordError(bool error) {
    state = state.copyWith(passwordError: error);
  }

  setPhone(String phone) {
    state = state.copyWith(phone: phone);
  }

  setPhoneError(bool error) {
    state = state.copyWith(phoneError: error);
  }

  setError(String error, [ErrorField? errorField]) {
    if (errorField != null) {
      switch (errorField) {
        case ErrorField.name:
          state = state.copyWith(
            errorMessage: error,
            fetchStatus: FetchStatus.error,
            nameError: true,
          );
          break;
        case ErrorField.email:
          state = state.copyWith(
            errorMessage: error,
            fetchStatus: FetchStatus.error,
            emailError: true,
          );
          break;
        case ErrorField.phone:
          state = state.copyWith(
            errorMessage: error,
            fetchStatus: FetchStatus.error,
            phoneError: true,
          );
          break;
        case ErrorField.password:
          state = state.copyWith(
            errorMessage: error,
            fetchStatus: FetchStatus.error,
            passwordError: true,
          );
          break;
        case ErrorField.confirmPassword:
          break;
      }

      return;
    }
    state = state.copyWith(
      errorMessage: error,
      fetchStatus: FetchStatus.error,
    );
  }
}

//state
@freezed
class EditProfilePageState with _$EditProfilePageState {
  const factory EditProfilePageState({
    UserModel? user,
    String? name,
    @Default(false) bool nameError,
    String? email,
    @Default(false) bool emailError,
    String? password,
    @Default(false) bool passwordError,
    String? phone,
    @Default(false) bool phoneError,
    @Default(FetchStatus.loading) FetchStatus fetchStatus,
    @Default(SaveStatus.initial) SaveStatus saveStatus,
    String? errorMessage,
  }) = _EditProfilePageState;
}

enum ErrorField {
  name,
  email,
  phone,
  password,
  confirmPassword,
}

enum FetchStatus {
  loading,
  error,
  loaded,
}

enum SaveStatus {
  initial,
  loading,
  error,
  loaded,
}
