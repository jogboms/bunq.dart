library installation;

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:bunq/src/models/Id.dart';
import 'package:bunq/src/models/ServerPublicKey.dart';
import 'package:bunq/src/models/Token.dart';
import 'package:bunq/src/utils/model.dart';
import 'package:bunq/src/utils/serializers.dart';

part 'Installation.g.dart';

abstract class Installation with ModelInterface implements Built<Installation, InstallationBuilder> {
  Installation._();

  factory Installation([updates(InstallationBuilder b)]) = _$Installation;

  @BuiltValueField(wireName: 'Id')
  Id get id;

  @BuiltValueField(wireName: 'Token')
  Token get token;

  @BuiltValueField(wireName: 'ServerPublicKey')
  ServerPublicKey get serverPublicKey;

  @override
  Map<String, dynamic> toMap() => serializers.serializeWith(Installation.serializer, this);

  static Installation fromJson(Map<String, dynamic> map) => serializers.deserializeWith(Installation.serializer, map);

  static Serializer<Installation> get serializer => _$installationSerializer;
}
