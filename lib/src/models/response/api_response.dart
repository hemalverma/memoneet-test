class ApiResponse<T> {
  final ApiStatus status;
  final String? errorMessage;
  final T? data;

  ApiResponse.error(this.errorMessage)
      : status = ApiStatus.error,
        data = null;

  ApiResponse.authError()
      : status = ApiStatus.authError,
        errorMessage = 'Please login to continue.',
        data = null;

  ApiResponse.success(T this.data)
      : status = ApiStatus.success,
        errorMessage = null;

  @override
  String toString() {
    return 'ApiResponse{status: $status, errorMessage: $errorMessage, data: $data}';
  }
}

enum ApiStatus {
  success,
  authError,
  error,
}
