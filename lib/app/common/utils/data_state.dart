enum Status { initial, loading, success, error }

class DataState<T> {
  Status status;
  T? data;
  String? message;
  int? statusCode;

  DataState({this.status = Status.initial, this.data, this.message, this.statusCode});

  DataState.loading() : status = Status.loading;
  DataState.success(T data, {int? statusCode}) : status = Status.success, data = data, statusCode = statusCode;
  DataState.error(String message, {int? statusCode}) : status = Status.error, message = message, statusCode = statusCode;
}
