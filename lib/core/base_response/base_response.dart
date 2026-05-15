sealed class BaseResponse<T> {}

class SuccessResponse<T> extends BaseResponse<T> {
  final T data;

  SuccessResponse({required this.data});
}

class ErrorResponse<T> extends BaseResponse<T> {
  final String errorMessage;
  ErrorResponse({required this.errorMessage});
}
