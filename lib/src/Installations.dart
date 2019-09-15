import 'package:bunq/src/Bunq.dart';
import 'package:bunq/src/models/Installation.dart';
import 'package:bunq/src/utils/endpoints.dart';
import 'package:bunq/src/utils/http_wrapper.dart';
import 'package:bunq/src/utils/log.dart';
import 'package:bunq/src/utils/response.dart';

class Installations {
  Installations() : _http = HttpWrapper();

  final HttpWrapper _http;

  Future<Response<Installation>> install() async {
    final payload = <String, dynamic>{"client_public_key": Bunq().publicKeyPem};
    Log().debug("$runtimeType.install()", payload);

    final _response = Response<Installation>(
      await _http.post(Endpoints.installations, payload),
      onTransform: (dynamic data, _) => Installation.fromJson(data),
    );

    Log().debug("$runtimeType.install() -> Response", _response);
    return _response;
  }
}
