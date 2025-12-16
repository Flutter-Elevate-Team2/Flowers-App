class BaseState<T> {
  bool? isLoading;
  String? errorMessage;
  T? data;

  BaseState({this.isLoading = false, this.errorMessage, this.data});
}