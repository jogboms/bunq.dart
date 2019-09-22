import 'package:bunq/src/Bunq.dart';
import 'package:bunq/src/utils/http_wrapper.dart';

class Api {
  Api() : http = HttpWrapper(baseUrl: Bunq().baseUrl, privateKey: Bunq().privateKey);

  final HttpWrapper http;
}
