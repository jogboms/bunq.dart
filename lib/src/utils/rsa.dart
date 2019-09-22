import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:asn1lib/asn1lib.dart';
import 'package:pointycastle/export.dart';

class Rsa {
  factory Rsa() {
    final params = RSAKeyGeneratorParameters(BigInt.from(65537), 2048, 12);
    final keys = (RSAKeyGenerator()..init(ParametersWithRandom(params, _generateSecureRandom()))).generateKeyPair();
    return Rsa._(keys.privateKey, keys.publicKey);
  }

  Rsa._(this.privateKey, this.publicKey);

  final RSAPrivateKey privateKey;

  final RSAPublicKey publicKey;

  static String sign(String plainText, PrivateKey privateKey) {
    final signer = RSASigner(SHA256Digest(), "0609608648016503040201")
      ..init(true, PrivateKeyParameter<RSAPrivateKey>(privateKey));
    return base64Encode(
      signer.generateSignature(_fromUint8ListToString(plainText)).bytes,
    );
  }

  String privateKeyPem() {
    final version = ASN1Integer(BigInt.from(0));
    final publicKeyBytes = (ASN1Sequence()
          ..add(version)
          ..add(ASN1Integer(privateKey.n))
          ..add(ASN1Integer(BigInt.parse('65537')))
          ..add(ASN1Integer(privateKey.d))
          ..add(ASN1Integer(privateKey.p))
          ..add(ASN1Integer(privateKey.q))
          ..add(ASN1Integer(privateKey.d % (privateKey.p - BigInt.from(1))))
          ..add(ASN1Integer(privateKey.d % (privateKey.q - BigInt.from(1))))
          ..add(ASN1Integer(privateKey.q.modInverse(privateKey.p))))
        .encodedBytes;
    final algorithmSeq = (ASN1Sequence()
      ..add(ASN1Object.fromBytes(Uint8List.fromList([0x6, 0x9, 0x2a, 0x86, 0x48, 0x86, 0xf7, 0xd, 0x1, 0x1, 0x1])))
      ..add(ASN1Object.fromBytes(Uint8List.fromList([0x5, 0x0]))));
    final encodedBytes = (ASN1Sequence()
          ..add(version)
          ..add(algorithmSeq)
          ..add(ASN1OctetString(Uint8List.fromList(publicKeyBytes))))
        .encodedBytes;

    return """-----BEGIN PRIVATE KEY-----\r\n${base64.encode(encodedBytes)}\r\n-----END PRIVATE KEY-----""";
  }

  String publicKeyPem() {
    final publicKeyBytes =
        (ASN1Sequence()..add(ASN1Integer(publicKey.modulus))..add(ASN1Integer(publicKey.exponent))).encodedBytes;
    final algorithmSeq = ASN1Sequence()
      ..add(ASN1Object.fromBytes(Uint8List.fromList([0x6, 0x9, 0x2a, 0x86, 0x48, 0x86, 0xf7, 0xd, 0x1, 0x1, 0x1])))
      ..add(ASN1Object.fromBytes(Uint8List.fromList([0x5, 0x0])));
    final encodedBytes =
        (ASN1Sequence()..add(algorithmSeq)..add(ASN1BitString(Uint8List.fromList(publicKeyBytes)))).encodedBytes;

    return """-----BEGIN PUBLIC KEY-----\r\n${base64.encode(encodedBytes)}\r\n-----END PUBLIC KEY-----""";
  }
}

Uint8List _fromUint8ListToString(String s) {
  final codec = Utf8Codec(allowMalformed: true);
  return Uint8List.fromList(codec.encode(s));
}

SecureRandom _generateSecureRandom() {
  final random = Random.secure();
  final List<int> seeds = [for (int i = 0; i < 32; i++) random.nextInt(255)];
  return FortunaRandom()..seed(KeyParameter(Uint8List.fromList(seeds)));
}
