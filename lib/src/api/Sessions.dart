import 'package:bunq/src/Bunq.dart';
import 'package:bunq/src/models/Session.dart';
import 'package:bunq/src/utils/api.dart';
import 'package:bunq/src/utils/endpoints.dart';
import 'package:bunq/src/utils/log.dart';
import 'package:bunq/src/utils/response.dart';

class Sessions extends Api {
  Future<Response<Session>> start(String token, int deviceId) async {
    final payload = <String, dynamic>{"secret": Bunq().apiKey};
    Log().debug("$runtimeType.start()", payload);

    final _response = Response<Session>(
      await http.post(Endpoints.sessions, payload, shouldSign: true, token: token),
      onTransform: Session.fromJson,
    );

    Log().debug("$runtimeType.start() -> Response", _response);
    return _response;
  }
}
