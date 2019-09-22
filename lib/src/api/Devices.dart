import 'package:bunq/src/Bunq.dart';
import 'package:bunq/src/models/Device.dart';
import 'package:bunq/src/utils/api.dart';
import 'package:bunq/src/utils/endpoints.dart';
import 'package:bunq/src/utils/log.dart';
import 'package:bunq/src/utils/response.dart';

class Devices extends Api {
  Future<Response<Device>> register(String token) async {
    final payload = <String, dynamic>{
      "secret": Bunq().apiKey,
      "description": "Bunq.dart",
      "permitted_ips": ["*"]
    };
    Log().debug("$runtimeType.register()", payload);

    final _response = Response<Device>(
      await http.post(Endpoints.devices, payload, shouldSign: true, token: token),
      onTransform: Device.fromJson,
    );

    Log().debug("$runtimeType.register() -> Response", _response);
    return _response;
  }
}
