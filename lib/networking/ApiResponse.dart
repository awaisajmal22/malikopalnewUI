import '../utils/Const.dart';

class ApiResponse<T> {
  Status status = Status.ERROR;
  T? data;
  String message = "";

  ApiResponse.loading([String? message]) {
    this.message = message == null ? Constant.COMMON_PLEASE_WAIT : message;
    status = Status.LOADING;
  }

  ApiResponse.completed(this.data) : status = Status.COMPLETED;

  ApiResponse.error(this.message) : status = Status.ERROR;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}

enum Status { LOADING, COMPLETED, ERROR, }
