import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import "package:asn1lib/asn1lib.dart";
import "package:pointycastle/export.dart";

class RsaKeyHelper {
  AsymmetricKeyPair<PublicKey, PrivateKey> _keys;

  RsaKeyHelper() {
    final keyParams = RSAKeyGeneratorParameters(BigInt.from(65537), 2048, 12);
    final rngParams = ParametersWithRandom(keyParams, _getSecureRandom());
    _keys = (RSAKeyGenerator()..init(rngParams)).generateKeyPair();
  }

  AsymmetricKeyPair<PublicKey, PrivateKey> get keys => _keys;

  /// Sign plain text with Private Key
  ///
  /// Given a plain text [String] and a [RSAPrivateKey], decrypt the text using
  /// a [RSAEngine] cipher
  static String sign(String plainText, PrivateKey privateKey) {
    final signer = RSASigner(SHA256Digest(), "0609608648016503040201")
      ..init(true, PrivateKeyParameter<RSAPrivateKey>(privateKey));
    return base64Encode(
      signer.generateSignature(_createUint8ListFromString(plainText)).bytes,
    );
  }

  String privateKeyPem() {
    final RSAPrivateKey key = _keys.privateKey;
    final version = ASN1Integer(BigInt.from(0));
    final publicKeyBytes = (ASN1Sequence()
          ..add(version)
          ..add(ASN1Integer(key.n))
          ..add(ASN1Integer(BigInt.parse('65537')))
          ..add(ASN1Integer(key.d))
          ..add(ASN1Integer(key.p))
          ..add(ASN1Integer(key.q))
          ..add(ASN1Integer(key.d % (key.p - BigInt.from(1))))
          ..add(ASN1Integer(key.d % (key.q - BigInt.from(1))))
          ..add(ASN1Integer(key.q.modInverse(key.p))))
        .encodedBytes;
    final algorithmSeq = (ASN1Sequence()
      ..add(ASN1Object.fromBytes(Uint8List.fromList(
          [0x6, 0x9, 0x2a, 0x86, 0x48, 0x86, 0xf7, 0xd, 0x1, 0x1, 0x1])))
      ..add(ASN1Object.fromBytes(Uint8List.fromList([0x5, 0x0]))));
    final encodedBytes = (ASN1Sequence()
          ..add(version)
          ..add(algorithmSeq)
          ..add(ASN1OctetString(Uint8List.fromList(publicKeyBytes))))
        .encodedBytes;

    final dataBase64 = base64.encode(encodedBytes);
    return """-----BEGIN PRIVATE KEY-----\r\n$dataBase64\r\n-----END PRIVATE KEY-----""";
  }

  String publicKeyPem() {
    final RSAPublicKey key = _keys.publicKey;
    final publicKeyBytes = (ASN1Sequence()
          ..add(ASN1Integer(key.modulus))
          ..add(ASN1Integer(key.exponent)))
        .encodedBytes;
    final algorithmSeq = ASN1Sequence()
      ..add(ASN1Object.fromBytes(Uint8List.fromList(
          [0x6, 0x9, 0x2a, 0x86, 0x48, 0x86, 0xf7, 0xd, 0x1, 0x1, 0x1])))
      ..add(ASN1Object.fromBytes(Uint8List.fromList([0x5, 0x0])));
    final encodedBytes = (ASN1Sequence()
          ..add(algorithmSeq)
          ..add(ASN1BitString(Uint8List.fromList(publicKeyBytes))))
        .encodedBytes;

    var dataBase64 = base64.encode(encodedBytes);
    return """-----BEGIN PUBLIC KEY-----\r\n$dataBase64\r\n-----END PUBLIC KEY-----""";
  }
}

/// Creates a [Uint8List] from a string to be signed
Uint8List _createUint8ListFromString(String s) {
  final codec = Utf8Codec(allowMalformed: true);
  return Uint8List.fromList(codec.encode(s));
}

SecureRandom _getSecureRandom() {
  final random = Random.secure();
  List<int> seeds = [];
  for (int i = 0; i < 32; i++) {
    seeds.add(random.nextInt(255));
  }
  return FortunaRandom()..seed(KeyParameter(Uint8List.fromList(seeds)));
}

/// Decode Private key from PEM Format
///
/// Given a base64 encoded PEM [String] with correct headers and footers, return a
/// [RSAPrivateKey]
RSAPrivateKey _parsePrivateKeyFromPem(pemString) {
  List<int> privateKeyDER = _decodePEM(pemString);
  var asn1Parser = ASN1Parser(privateKeyDER);
  final topLevelSeq = asn1Parser.nextObject() as ASN1Sequence;

  var modulus, privateExponent, p, q;
  // Depending on the number of elements, we will either use PKCS1 or PKCS8
  if (topLevelSeq.elements.length == 3) {
    final privateKey = topLevelSeq.elements[2];

    asn1Parser = ASN1Parser(privateKey.contentBytes());
    final pkSeq = asn1Parser.nextObject() as ASN1Sequence;

    modulus = pkSeq.elements[1] as ASN1Integer;
    privateExponent = pkSeq.elements[3] as ASN1Integer;
    p = pkSeq.elements[4] as ASN1Integer;
    q = pkSeq.elements[5] as ASN1Integer;
  } else {
    modulus = topLevelSeq.elements[1] as ASN1Integer;
    privateExponent = topLevelSeq.elements[3] as ASN1Integer;
    p = topLevelSeq.elements[4] as ASN1Integer;
    q = topLevelSeq.elements[5] as ASN1Integer;
  }

  return RSAPrivateKey(
    modulus.valueAsBigInteger,
    privateExponent.valueAsBigInteger,
    p.valueAsBigInteger,
    q.valueAsBigInteger,
  );
}

RSAPublicKey _parsePublicKeyFromPem(pemString) {
  List<int> publicKeyDER = _decodePEM(pemString);
  final asn1Parser = ASN1Parser(publicKeyDER);
  final topLevelSeq = asn1Parser.nextObject() as ASN1Sequence;

  var modulus, exponent;
  // Depending on the first element type, we either have PKCS1 or 2
  if (topLevelSeq.elements[0].runtimeType == ASN1Integer) {
    modulus = topLevelSeq.elements[0] as ASN1Integer;
    exponent = topLevelSeq.elements[1] as ASN1Integer;
  } else {
    final publicKeyBitString = topLevelSeq.elements[1];

    final publicKeyAsn = ASN1Parser(publicKeyBitString.contentBytes());
    ASN1Sequence publicKeySeq = publicKeyAsn.nextObject();
    modulus = publicKeySeq.elements[0] as ASN1Integer;
    exponent = publicKeySeq.elements[1] as ASN1Integer;
  }

  return RSAPublicKey(modulus.valueAsBigInteger, exponent.valueAsBigInteger);
}

List<int> _decodePEM(String pem) {
  return base64.decode(_removePemHeaderAndFooter(pem));
}

String _removePemHeaderAndFooter(String pem) {
  final startsWith = [
    "-----BEGIN PUBLIC KEY-----",
    "-----BEGIN RSA PRIVATE KEY-----",
    "-----BEGIN RSA PUBLIC KEY-----",
    "-----BEGIN PRIVATE KEY-----",
    "-----BEGIN PGP PUBLIC KEY BLOCK-----\r\nVersion: React-Native-OpenPGP.js 0.1\r\nComment: http://openpgpjs.org\r\n\r\n",
    "-----BEGIN PGP PRIVATE KEY BLOCK-----\r\nVersion: React-Native-OpenPGP.js 0.1\r\nComment: http://openpgpjs.org\r\n\r\n",
  ];
  final endsWith = [
    "-----END PUBLIC KEY-----",
    "-----END PRIVATE KEY-----",
    "-----END RSA PRIVATE KEY-----",
    "-----END RSA PUBLIC KEY-----",
    "-----END PGP PUBLIC KEY BLOCK-----",
    "-----END PGP PRIVATE KEY BLOCK-----",
  ];
  bool isOpenPgp = pem.contains('BEGIN PGP');

  pem = pem.replaceAll(' ', '');
  pem = pem.replaceAll('\n', '');
  pem = pem.replaceAll('\r', '');

  for (var s in startsWith) {
    s = s.replaceAll(' ', '');
    if (pem.startsWith(s)) {
      pem = pem.substring(s.length);
    }
  }

  for (var s in endsWith) {
    s = s.replaceAll(' ', '');
    if (pem.endsWith(s)) {
      pem = pem.substring(0, pem.length - s.length);
    }
  }

  if (isOpenPgp) {
    final index = pem.indexOf('\r\n');
    pem = pem.substring(0, index);
  }

  return pem;
}
