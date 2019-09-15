import 'package:bunq/src/Bunq.dart';
import 'package:bunq/src/models/Device.dart';
import 'package:bunq/src/utils/endpoints.dart';
import 'package:bunq/src/utils/http_wrapper.dart';
import 'package:bunq/src/utils/log.dart';
import 'package:bunq/src/utils/response.dart';

class Devices {
  Devices() : _http = HttpWrapper();

  final HttpWrapper _http;

  Future<Response<Device>> register(String token) async {
    final payload = <String, dynamic>{
      "secret": Bunq().apiKey,
      "description": "Bunq.dart",
      "permitted_ips": ["*"]
    };
    Log().debug("$runtimeType.register()", payload);

    final _response = Response<Device>(
      await _http.post(Endpoints.devices, payload, shouldSign: true, token: token),
      onTransform: (dynamic data, _) => Device.fromJson(data),
    );

    Log().debug("$runtimeType.register() -> Response", _response);
    return _response;
  }
}
