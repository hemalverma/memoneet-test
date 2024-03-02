import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infotexh_test/src/logic/services/isar_database.dart';
import 'package:infotexh_test/src/models/user_model.dart';

import '../services/local_db/collections/login.dart';

part 'app_repository.freezed.dart';

final appRepositoryProvider =
    StateNotifierProvider<AppRepositoryModel, AppRepositoryState>(
  (ref) => AppRepositoryModel(
    ref: ref,
  ),
);

class AppRepositoryModel extends StateNotifier<AppRepositoryState> {
  final StateNotifierProviderRef ref;
  AppRepositoryModel({
    required this.ref,
  }) : super(AppRepositoryState()) {
    checkLoggedInUser();
  }

  checkLoggedInUser() async {
    setAppStatus(AppState.authenticating);
    LoginCollection.isLoggedInSession().then((value) async {
      if (value != null) {
        print('user id ${value.userId}');
        final user = await IsarDatabase.fetchById(value.userId!);
        if (user != null) {
          print(user.name);
          state = state.copyWith(
              appStatus: AppState.authenticated, userModel: user);
        } else {
          setAppStatus(AppState.unauthenticated);
        }
      } else {
        setAppStatus(AppState.unauthenticated);
      }
    });
  }

  updateData() async {
    if (state.userModel != null) {
      final data = await IsarDatabase.fetchById(state.userModel!.id);
      state = state.copyWith(userModel: data);
    }
  }

  logout() async {
    if (state.userModel != null) {
      print('user not null');
      final res = await LoginCollection.clearLoggedInSession();
      if (res) {
        setAppStatus(AppState.unauthenticated);
      }
    }
  }

  void setUser(UserModel userModel) {
    state = state.copyWith(
      userModel: userModel,
      appStatus: AppState.authenticated,
    );
  }

  void removeUser() {
    state = state.copyWith(
      userModel: null,
      appStatus: AppState.unauthenticated,
    );
  }

  void setAppStatus(AppState appState) {
    state = state.copyWith(appStatus: appState);
  }

  void setErrorMessage(String errorMessage) {
    state = state.copyWith(errorMessage: errorMessage);
  }
}

@freezed
class AppRepositoryState with _$AppRepositoryState {
  factory AppRepositoryState({
    UserModel? userModel,
    @Default(AppState.authenticating) AppState appStatus,
    String? errorMessage,
  }) = _AppRepositoryState;
}

enum AppState {
  authenticating,
  authenticated,
  unauthenticated,
  failed,
}
