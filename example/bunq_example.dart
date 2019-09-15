import 'package:bunq/src/util/rsa.dart';
import 'package:pointycastle/export.dart';

main() {
  var keyParams = RSAKeyGeneratorParameters(BigInt.from(65537), 2048, 5);

  SecureRandom random = RsaKeyHelper().getSecureRandom();

  print(random.toString());

  var rngParams =
      ParametersWithRandom(keyParams, RsaKeyHelper().getSecureRandom());
  var k = RSAKeyGenerator();
  k.init(rngParams);

  var keyPair = k.generateKeyPair();

  print(RsaKeyHelper().encodePublicKeyToPemPKCS1(keyPair.publicKey));
  print(RsaKeyHelper().encodePrivateKeyToPemPKCS1(keyPair.privateKey));
//
//  AsymmetricKeyParameter<RSAPublicKey> keyParametersPublic =
//      PublicKeyParameter(keyPair.publicKey);
//  var cipher = RSAEngine()..init(true, keyParametersPublic);
//
//  var cipherText = cipher.process(Uint8List.fromList("Hello World".codeUnits));
//
//  print("Encrypted: ${String.fromCharCodes(cipherText)}");
//
//  AsymmetricKeyParameter<RSAPrivateKey> keyParametersPrivate =
//      PrivateKeyParameter(keyPair.privateKey);
//
//  cipher.init(false, keyParametersPrivate);
//  var decrypted = cipher.process(cipherText);
//  print("Decrypted: ${String.fromCharCodes(decrypted)}");
}
