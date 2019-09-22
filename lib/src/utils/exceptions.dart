import 'dart:io';

import 'package:bunq/src/constants/strings.dart';

class ForbiddenException extends ResponseException {
  ForbiddenException([String message]) : super(HttpStatus.forbidden, message);
}

class TimeOutException extends ResponseException {
  TimeOutException() : super(HttpStatus.requestTimeout, Strings.timeoutErrorMessage);
}

class BadRequestException extends ResponseException {
  BadRequestException([String message]) : super(HttpStatus.badRequest, message);
}

class UnAuthorisedException extends ResponseException {
  UnAuthorisedException([String message]) : super(HttpStatus.unauthorized, message);
}

class ResponseException implements Exception {
  ResponseException(this.statusCode, [this.message]);

  final int statusCode;
  final String message;

  @override
  String toString() => message;
}
