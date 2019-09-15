import 'package:bunq/src/constants/url.dart';
import 'package:bunq/src/util/log.dart';
import 'package:meta/meta.dart';

class Bunq {
  factory Bunq() {
    assert(_instance != null,
        'Please make sure to call Bunq.init() at the top of your app or before using the other functions.');
    return _instance;
  }

  Bunq._({
    @required this.publicKey,
    @required this.secretKey,
    @required this.production,
  }) : baseUrl = production ? Url.Prod : Url.Staging;

  @visibleForTesting
  static void reset() {
    _instance = null;
  }

  static void init({
    @required String publicKey,
    @required String secretKey,
    @required bool production,
    bool useLogger = false,
    bool restart = false,
  }) {
    assert(publicKey != null);
    assert(secretKey != null);
    assert(production != null);
    assert((_instance != null && restart == true) || _instance == null,
        'Are you trying to reset the previous keys by calling Bunq.init() again?.');
    _instance = Bunq._(
      publicKey: publicKey,
      secretKey: secretKey,
      production: production,
    );
    // Initialize logger
    Log.init(!useLogger);
  }

  static Bunq _instance;

  final String publicKey;
  final String secretKey;
  final bool production;
  final String baseUrl;

  @override
  String toString() {
    return '$runtimeType(publicKey: $publicKey, secretKey: $secretKey, production: $production, baseUrl: $baseUrl)';
  }
}
