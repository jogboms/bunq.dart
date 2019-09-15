library serverPublicKey;

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:bunq/src/utils/model.dart';
import 'package:bunq/src/utils/serializers.dart';

part 'ServerPublicKey.g.dart';

abstract class ServerPublicKey with ModelInterface implements Built<ServerPublicKey, ServerPublicKeyBuilder> {
  ServerPublicKey._();

  factory ServerPublicKey([updates(ServerPublicKeyBuilder b)]) = _$ServerPublicKey;

  @BuiltValueField(wireName: 'server_public_key')
  String get serverPublicKey;

  @override
  Map<String, dynamic> toMap() => serializers.serializeWith(ServerPublicKey.serializer, this);

  static ServerPublicKey fromJson(Map<String, dynamic> map) =>
      serializers.deserializeWith(ServerPublicKey.serializer, map);

  static Serializer<ServerPublicKey> get serializer => _$serverPublicKeySerializer;
}
