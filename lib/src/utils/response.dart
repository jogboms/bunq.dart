import 'dart:io';

import 'package:bunq/src/Bunq.dart';
import 'package:bunq/src/constants/strings.dart';
import 'package:bunq/src/utils/exceptions.dart';
import 'package:bunq/src/utils/log.dart';
import 'package:bunq/src/utils/model.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

typedef TransformFunction<T> = T Function(Map<String, dynamic> data);

class Response<T extends ModelInterface> with ModelInterface {
  factory Response(http.Response _response, {TransformFunction<T> onTransform, bool shouldThrow = true}) {
    final status = _Status(_response.statusCode);
    try {
      final Map<String, dynamic> response = Model.stringToMap(_response.body);

      if (response == null || response is! Map) {
        throw ResponseException(status.code, _response.reasonPhrase);
      }

      if (status.isNotOk) {
        final error = _formatResponse(response["Error"]);
        throw ResponseException(
          status.code,
          error["error_description_translated"] ?? error["error_description"],
        );
      }

      return Response._(
        status: status,
        message: _response.reasonPhrase,
        data: onTransform != null
            ? onTransform(_formatResponse(response["Response"], response.containsKey("Pagination")))
            : null,
      );
    } catch (e) {
      Log().error('Response.catch', e);
      final message = status.code == HttpStatus.badGateway && Bunq().production ? Strings.errorMessage : e.toString();

      if (shouldThrow) {
        if (status.isForbidden) {
          throw ForbiddenException(message);
        }

        if (status.isNotAuthorized) {
          throw UnAuthorisedException(message);
        }

        if (status.isBadRequest) {
          throw BadRequestException(message);
        }

        throw ResponseException(status.code, message);
      }

      return Response._(status: status, message: message);
    }
  }

  Response._({@required this.status, @required this.message, this.data});

  final _Status status;
  final String message;
  final T data;

  @override
  Map<String, dynamic> toMap() => <String, dynamic>{"status": status.code, "message": message, "data": data?.toMap()};
}

/// dynamic being used here could either be a List of items or just an item
Map<String, dynamic> _formatResponse(List<dynamic> response, [bool hasMultiple = false]) {
  return response.fold(<String, dynamic>{}, (Map<String, dynamic> model, dynamic el) {
    if (el is Map<String, dynamic>) {
      final key = el.keys.first;
      final Map<String, dynamic> value = el[key];
      return model..update(key, (dynamic prev) => prev..add(value), ifAbsent: () => hasMultiple ? [value] : value);
    }

    return model;
  });
}

class _Status {
  _Status(this.code);

  final int code;

  bool get isOk => code >= HttpStatus.ok && code < HttpStatus.multipleChoices;

  bool get isNotOk => !isOk;

  bool get isBadRequest => code == HttpStatus.badRequest;

  bool get isNotFound => code == HttpStatus.notFound;

  bool get isNotAuthorized => code == HttpStatus.unauthorized;

  bool get isForbidden => code == HttpStatus.forbidden;
}
