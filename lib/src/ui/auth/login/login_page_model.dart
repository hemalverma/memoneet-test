import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:memoneet_test/src/logic/repo/app_repository.dart';
import 'package:memoneet_test/src/models/response/api_response.dart';

import '../../../logic/services/api/api_service.dart';
import '../register/register_page_model.dart';

part 'login_page_model.freezed.dart';

//provider
final loginPageModelProvider =
    StateNotifierProvider<LoginPageModel, LoginPageState>(
  (ref) => LoginPageModel(
    apiService: ref.watch(apiServiceProvider),
    ref: ref,
  ),
);

//view_model
class LoginPageModel extends StateNotifier<LoginPageState> {
  final ApiService apiService;
  StateNotifierProviderRef ref;
  LoginPageModel({
    required this.apiService,
    required this.ref,
  }) : super(const LoginPageState());

  validateAndLogin() {
    state = state.copyWith(loginStatus: LoginStatus.logging);

    if (state.email == null || state.email == '') {
      setError('Email is required', ErrorField.email);
      return;
    }

    if (state.password == null) {
      setError('Password is required', ErrorField.password);
      return;
    }

    if (state.password!.length < 6) {
      setError('Password is invalid', ErrorField.password);
      return;
    }

    loginUser();
  }

  loginUser() async {
    //api call
    try {
      final response = await apiService.login(
        email: state.email!,
        password: state.password!,
      );
      if (response.status != ApiStatus.success) {
        setError(response.errorMessage ?? 'Login Failed');
        return;
      }
      if (response.data == null) {
        setError('Login Failed');
        return;
      }
      //login success
      ref.read(appRepositoryProvider.notifier).setUser(response.data!);
      state = state.copyWith(loginStatus: LoginStatus.loginSuccess);
    } catch (e) {
      setError(e.toString());
      return;
    }
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

  setError(String error, [ErrorField? errorField]) {
    if (errorField == ErrorField.email) {
      state = state.copyWith(
        errorMessage: error,
        emailError: true,
        loginStatus: LoginStatus.loginFailed,
      );
      return;
    }
    if (errorField == ErrorField.password) {
      state = state.copyWith(
        errorMessage: error,
        passwordError: true,
        loginStatus: LoginStatus.loginFailed,
      );
      return;
    }
    state = state.copyWith(
      errorMessage: error,
      loginStatus: LoginStatus.loginFailed,
    );
  }
}

//state
@freezed
class LoginPageState with _$LoginPageState {
  const factory LoginPageState({
    String? email,
    @Default(false) bool emailError,
    String? password,
    @Default(false) bool passwordError,
    @Default(LoginStatus.initial) LoginStatus loginStatus,
    String? errorMessage,
  }) = _LoginPageState;
}

enum LoginStatus {
  initial,
  logging,
  loginFailed,
  loginSuccess,
}
