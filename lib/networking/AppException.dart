class AppException implements Exception {
  final _message;
  final _prefix;
  final int _responseCode;

  AppException(this._responseCode, [this._message, this._prefix]);

  String toString() {
    return "$_prefix$_message";
  }

  int getErrorCode() => _responseCode;
}

class FetchDataException extends AppException {
  FetchDataException(int responseCode, [String? message])
      : super(responseCode, message, "Error During Communication: ");
}

class BadRequestException extends AppException {
  BadRequestException(int responseCode, [message])
      : super(responseCode, message, "");
}

class UnauthorisedException extends AppException {
  UnauthorisedException(int responseCode, [message])
      : super(responseCode, message, "Unauthorised: ");
}

class InvalidInputException extends AppException {
  InvalidInputException(int responseCode, [String? message])
      : super(responseCode, message, "Invalid Input: ");
}
