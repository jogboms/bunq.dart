import 'dart:async';
import 'dart:convert';

import 'package:bunq/src/Bunq.dart';
import 'package:bunq/src/utils/exceptions.dart';
import 'package:bunq/src/utils/log.dart';
import 'package:bunq/src/utils/rsa.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class HttpWrapper {
  HttpWrapper() : baseUrl = Bunq().baseUrl;

  static Map<String, String> get headers => {
        'Accept': 'application/json',
        'Cache-Control': 'no-cache',
        'Content-Type': 'application/json',
        'User-Agent': 'bunq.dart',
        'X-Bunq-Client-Request-Id': Uuid().v1(),
        'X-Bunq-Geolocation': '0 0 0 0 000',
        'X-Bunq-Language': 'en_US',
        'X-Bunq-Region': 'nl_NL',
      };

  final String baseUrl;

  Future<http.Response> get(
    String url, {
    bool shouldSign = false,
    String token,
    Map<String, String> headers = const <String, String>{},
    bool mergeHeaders = true,
  }) {
    assert(headers != null);

    if (shouldSign == true) {
      assert(token != null);
    }

    try {
      Log().debug("HttpWrapper.get() -> $url");

      Map<String, String> _headers = {if (mergeHeaders) ...HttpWrapper.headers, ...headers};
      if (shouldSign == true && token != null) {
        _headers = _signedHeaders("GET", url, token, "", _headers);
      }

      return http.get(baseUrl + url, headers: _headers);
    } on TimeoutException {
      throw TimeOutException();
    }
  }

  Future<http.Response> post(
    String url,
    Map<String, dynamic> data, {
    bool shouldSign = false,
    String token,
    Map<String, String> headers = const <String, String>{},
    bool mergeHeaders = true,
  }) {
    assert(headers != null);

    if (shouldSign == true) {
      assert(token != null);
    }

    try {
      final _body = json.encode(data);
      Log().debug("HttpWrapper.post() -> $url", _body);

      Map<String, String> _headers = {if (mergeHeaders) ...HttpWrapper.headers, ...headers};
      if (shouldSign == true && token != null) {
        _headers = _signedHeaders("POST", url, token, _body, _headers);
      }

      return http.post(baseUrl + url, headers: _headers, body: _body);
    } on TimeoutException {
      throw TimeOutException();
    }
  }
}

const _bunqHeaderPrefix = 'X-Bunq-';
const _allowedSignedHeaders = ['Cache-Control', 'User-Agent'];
const _ignoredSignedHeaders = ['X-Bunq-Client-Signature'];

Map<String, String> _signedHeaders(String method, String url, String token, String body, Map<String, String> headers) {
  final headersToSign = {...headers, 'X-Bunq-Client-Authentication': token};
  final dataToSign = "$method /$url\n${_normalizeHeaders(headersToSign)}\n$body";
  final signature = Rsa.sign(dataToSign, Bunq().privateKey);
  return {...headersToSign, 'X-Bunq-Client-Signature': signature};
}

String _normalizeHeaderName(String name) {
  return name.split("-").map((text) => text[0].toUpperCase() + text.substring(1).toLowerCase()).join("-");
}

bool _shouldHeaderBeSigned(String header) {
  if ((_allowedSignedHeaders.contains(header) || header.startsWith(_bunqHeaderPrefix)) &&
      !_ignoredSignedHeaders.contains(header)) {
    return true;
  }
  return false;
}

String _normalizeHeaders(Map<String, dynamic> headers) {
  final headerNames = headers.keys.toList();
  headerNames.sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));

  return headerNames.fold("", (acc, name) {
    final headerName = _normalizeHeaderName(name);
    if (_shouldHeaderBeSigned(headerName)) {
      return "${acc}${headerName}: ${headers[name]}\n";
    }
    return acc;
  });
}
