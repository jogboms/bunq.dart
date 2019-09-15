import 'package:bunq/src/constants/url.dart';
import 'package:bunq/src/utils/log.dart';
import 'package:bunq/src/utils/rsa.dart';
import 'package:meta/meta.dart';
import 'package:pointycastle/pointycastle.dart';

class Bunq {
  factory Bunq() {
    assert(_instance != null,
        'Please make sure to call Bunq.init() at the top of your app or before using the other functions.');
    return _instance;
  }

  Bunq._({
    @required this.apiKey,
    @required this.publicKey,
    @required this.privateKey,
    @required this.publicKeyPem,
    @required this.privateKeyPem,
    @required this.production,
  }) : baseUrl = production ? Url.Prod : Url.Staging;

  @visibleForTesting
  static void reset() {
    _instance = null;
  }

  static void init({
    @required String apiKey,
    @required bool production,
    bool useLogger = false,
    bool restart = false,
  }) {
    assert(apiKey != null);
    assert(production != null);
    assert((_instance != null && restart == true) || _instance == null,
        'Are you trying to reset the previous keys by calling Bunq.init() again?.');

    final rsa = RsaKeyHelper();

    _instance = Bunq._(
      apiKey: apiKey,
      publicKey: rsa.keys.publicKey,
      privateKey: rsa.keys.privateKey,
      publicKeyPem: rsa.publicKeyPem(),
      privateKeyPem: rsa.privateKeyPem(),
      production: production,
    );
    // Initialize logger
    Log.init(!useLogger);
  }

  static Bunq _instance;

  final String apiKey;
  final PublicKey publicKey;
  final PrivateKey privateKey;
  final String publicKeyPem;
  final String privateKeyPem;
  final bool production;
  final String baseUrl;

  @override
  String toString() {
    return '$runtimeType('
        'apiKey: $apiKey, '
        'publicKey: $publicKey, '
        'privateKey: $privateKey, '
        'publicKeyPem: $publicKeyPem, '
        'privateKeyPem: $privateKeyPem, '
        'production: $production, '
        'baseUrl: $baseUrl'
        ')';
  }
}
