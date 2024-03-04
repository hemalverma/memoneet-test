import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infotexh_test/src/models/response/api_response.dart';

import '../../../logic/services/api/api_service.dart';
import '../../../models/episode_data_model.dart';

part 'api_data_widget_model.freezed.dart';

//provider
final apiDataWidgetModelProvider =
    StateNotifierProvider<ApiDataWidgetModel, ApiDataWidgetState>(
  (ref) => ApiDataWidgetModel(
    apiService: ref.watch(apiServiceProvider),
    ref: ref,
  ),
);

//view_model
class ApiDataWidgetModel extends StateNotifier<ApiDataWidgetState> {
  final ApiService apiService;
  StateNotifierProviderRef ref;
  ApiDataWidgetModel({
    required this.apiService,
    required this.ref,
  }) : super(const ApiDataWidgetState());

  fetchData() async {
    state = state.copyWith(status: ApiDataStatus.loading);
    //api call
    try {
      final response = await apiService.fetchAllEpisodes();
      if (response.status != ApiStatus.success) {
        setError(response.errorMessage ?? 'Login Failed');
        return;
      }
      if (response.data == null) {
        setError('Failed to get Data');
        return;
      }
      //episode success
      state = state.copyWith(
        status: ApiDataStatus.loaded,
        episodes: response.data!,
      );
    } catch (e) {
      setError(e.toString());
      return;
    }
  }

  setError(String error) {
    state = state.copyWith(
      errorMessage: error,
      status: ApiDataStatus.error,
    );
  }
}

//state
@freezed
class ApiDataWidgetState with _$ApiDataWidgetState {
  const factory ApiDataWidgetState({
    List<SingleEpisode>? episodes,
    @Default(ApiDataStatus.loading) ApiDataStatus status,
    String? errorMessage,
  }) = _ApiDataWidgetState;
}

enum ApiDataStatus {
  loading,
  loaded,
  error,
}
