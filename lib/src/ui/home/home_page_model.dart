import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infotexh_test/src/models/response/api_response.dart';

import '../../logic/services/api/api_service.dart';
import '../../models/user_model.dart';

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

  fetchAllUsers() async {
    state = state.copyWith(status: HomeStatus.loading);
    //api call
    try {
      final response = await apiService.fetchAllUsers();
      if (response.status != ApiStatus.success) {
        setError(response.errorMessage ?? 'Login Failed');
        return;
      }
      if (response.data == null) {
        setError('Failed to get Data');
        return;
      }
      //login success
      state = state.copyWith(status: HomeStatus.loaded, users: response.data!);
    } catch (e) {
      setError(e.toString());
      return;
    }
  }

  setError(String error) {
    state = state.copyWith(
      errorMessage: error,
      status: HomeStatus.error,
    );
  }
}

//state
@freezed
class HomePageState with _$HomePageState {
  const factory HomePageState({
    List<UserModel>? users,
    @Default(HomeStatus.loading) HomeStatus status,
    String? errorMessage,
  }) = _HomePageState;
}

enum HomeStatus {
  loading,
  loaded,
  error,
}
