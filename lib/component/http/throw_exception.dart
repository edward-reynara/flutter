class ThrowException implements Exception {
  final dynamic _message;
  final dynamic _prefix;

  ThrowException([this._message, this._prefix]);

  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends ThrowException {
  FetchDataException([String message])
      : super(message, "Error During Communication: ");
}

class BadRequestException extends ThrowException {
  BadRequestException([String message]) : super(message, "Invalid Request: ");
}

class UnauthorisedException extends ThrowException {
  UnauthorisedException([String message]) : super(message, "Unauthorised: ");
}

class ExpiredTokenException extends ThrowException {
  ExpiredTokenException([int message]) : super(message, "ExpiredToken: ");
}

class InvalidInputException extends ThrowException {
  InvalidInputException([String message]) : super(message, "Invalid Input: ");
}

class RequestTimeoutException extends ThrowException {
  RequestTimeoutException([String message]) : super(message, "Gateway Timeout: ");
}
