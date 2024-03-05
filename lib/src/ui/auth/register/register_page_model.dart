import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:memoneet_test/src/models/user_model.dart';

import '../../../logic/services/api/api_service.dart';
import '../../../models/response/api_response.dart';

part 'register_page_model.freezed.dart';

//provider
final registerPageModelProvider =
    StateNotifierProvider<RegisterPageModel, RegisterPageState>(
  (ref) => RegisterPageModel(
    apiService: ref.watch(apiServiceProvider),
    ref: ref,
  ),
);

//view_model
class RegisterPageModel extends StateNotifier<RegisterPageState> {
  final ApiService apiService;
  StateNotifierProviderRef ref;
  RegisterPageModel({
    required this.apiService,
    required this.ref,
  }) : super(const RegisterPageState());

  validateAndRegister() {
    state = state.copyWith(registerStatus: RegisterStatus.registerProcessing);
    if (state.name == null || state.name == '') {
      setError('Name can\'t be empty', ErrorField.name);
      return;
    }

    if (state.email == null || state.email == '') {
      setError('Email can\'t be empty', ErrorField.email);
      return;
    }

    if (state.password == null) {
      setError('Password is must', ErrorField.password);
      return;
    }

    if (state.password!.length < 6) {
      setError('Password is too short', ErrorField.password);
      return;
    }
    if (state.password != state.confirmPassword) {
      setError('password and confirm password are not same',
          ErrorField.confirmPassword);
      return;
    } else {
      UserModel data = UserModel()
        ..name = state.name!
        ..email = state.email!
        ..password = state.password!;
      registerUser(data);
    }
  }

  registerUser(UserModel user) async {
    try {
      final response = await apiService.createUser(
        user: user,
      );
      if (response.status != ApiStatus.success) {
        setError(response.errorMessage ?? 'Register Failed');
        return;
      }
      if (response.data == null) {
        setError('Register Failed');
        return;
      }
      //register success
      state = state.copyWith(registerStatus: RegisterStatus.registerSuccess);
    } catch (e) {
      setError(e.toString());
      return;
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

  setConfirmPassword(String confirmPassword) {
    state = state.copyWith(confirmPassword: confirmPassword);
  }

  setConfirmPasswordError(bool error) {
    state = state.copyWith(confirmPasswordError: error);
  }

  setError(String error, [ErrorField? errorField]) {
    if (errorField != null) {
      switch (errorField) {
        case ErrorField.name:
          state = state.copyWith(
            errorMessage: error,
            registerStatus: RegisterStatus.registerError,
            nameError: true,
          );
          break;
        case ErrorField.email:
          state = state.copyWith(
            errorMessage: error,
            registerStatus: RegisterStatus.registerError,
            emailError: true,
          );
          break;
        case ErrorField.password:
          state = state.copyWith(
            errorMessage: error,
            registerStatus: RegisterStatus.registerError,
            passwordError: true,
          );
          break;
        case ErrorField.confirmPassword:
          state = state.copyWith(
            errorMessage: error,
            registerStatus: RegisterStatus.registerError,
            confirmPasswordError: true,
          );
          break;
      }

      return;
    }
    state = state.copyWith(
      errorMessage: error,
      registerStatus: RegisterStatus.registerError,
    );
  }
}

//state
@freezed
class RegisterPageState with _$RegisterPageState {
  const factory RegisterPageState({
    String? name,
    @Default(false) bool nameError,
    String? email,
    @Default(false) bool emailError,
    String? password,
    @Default(false) bool passwordError,
    String? confirmPassword,
    @Default(false) bool confirmPasswordError,
    @Default(RegisterStatus.initial) RegisterStatus registerStatus,
    String? errorMessage,
  }) = _RegisterPage;
}

enum ErrorField {
  name,
  email,
  password,
  confirmPassword,
}

enum RegisterStatus {
  initial,
  registerProcessing,
  registerError,
  registerSuccess,
}
