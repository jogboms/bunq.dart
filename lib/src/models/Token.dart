library token;

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:bunq/src/utils/model.dart';
import 'package:bunq/src/utils/serializers.dart';

part 'Token.g.dart';

abstract class Token with ModelInterface implements Built<Token, TokenBuilder> {
  Token._();

  factory Token([Function(TokenBuilder b) updates]) = _$Token;

  DateTime get created;

  int get id;

  String get token;

  DateTime get updated;

  @override
  Map<String, dynamic> toMap() => serializers.serializeWith(Token.serializer, this);

  static Token fromJson(Map<String, dynamic> map) => serializers.deserializeWith(Token.serializer, map);

  static Serializer<Token> get serializer => _$tokenSerializer;
}
