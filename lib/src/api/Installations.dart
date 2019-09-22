import 'package:bunq/src/Bunq.dart';
import 'package:bunq/src/models/Installation.dart';
import 'package:bunq/src/utils/api.dart';
import 'package:bunq/src/utils/endpoints.dart';
import 'package:bunq/src/utils/log.dart';
import 'package:bunq/src/utils/response.dart';

class Installations extends Api {
  Future<Response<Installation>> install() async {
    final payload = <String, dynamic>{"client_public_key": Bunq().publicKeyPem};
    Log().debug("$runtimeType.install()", payload);

    final _response = Response<Installation>(
      await http.post(Endpoints.installations, payload),
      onTransform: Installation.fromJson,
    );

    Log().debug("$runtimeType.install() -> Response", _response);
    return _response;
  }
}
