import 'dart:async';
import 'dart:convert';

import 'package:bunq/src/bunq_base.dart';
import 'package:bunq/src/util/exceptions.dart';
import 'package:bunq/src/util/log.dart';
import 'package:http/http.dart' as http;

class HttpWrapper {
  HttpWrapper() : baseUrl = Bunq().baseUrl;

  static final Map<String, String> _headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json'
  };

  final String baseUrl;

  Future<http.Response> get(String url) {
    try {
      Log().debug("HttpWrapper.get() -> $url");
      return http.get(baseUrl + url, headers: _headers);
    } on TimeoutException {
      throw TimeOutException();
    }
  }

  Future<http.Response> post(String url, Map<String, dynamic> data) {
    try {
      final _body = json.encode(data);
      Log().debug("HttpWrapper.post() -> $url", _body);
      return http.post(
        baseUrl + url,
        headers: _headers,
        body: _body,
      );
    } on TimeoutException {
      throw TimeOutException();
    }
  }
}
