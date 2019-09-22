import 'package:bunq/src/models/MonetaryAccount.dart';
import 'package:bunq/src/utils/api.dart';
import 'package:bunq/src/utils/endpoints.dart';
import 'package:bunq/src/utils/log.dart';
import 'package:bunq/src/utils/response.dart';

class Accounts extends Api {
  Future<Response<MonetaryAccount>> fetch(String token, int userId) async {
    Log().debug("$runtimeType.fetch()", userId);

    final _response = Response<MonetaryAccount>(
      await http.get(Endpoints.accounts.replaceAll("{{ID}}", userId.toString()), shouldSign: true, token: token),
      onTransform: MonetaryAccount.fromJson,
    );

    Log().debug("$runtimeType.fetch() -> Response", _response);
    return _response;
  }
}
