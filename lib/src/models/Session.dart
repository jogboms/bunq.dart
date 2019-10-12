library session;

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:bunq/src/models/Id.dart';
import 'package:bunq/src/models/Token.dart';
import 'package:bunq/src/models/UserPerson.dart';
import 'package:bunq/src/utils/model.dart';
import 'package:bunq/src/utils/serializers.dart';

part 'Session.g.dart';

abstract class Session with ModelInterface implements Built<Session, SessionBuilder> {
  Session._();

  factory Session([Function(SessionBuilder b) updates]) = _$Session;

  @BuiltValueField(wireName: 'Id')
  Id get id;

  @BuiltValueField(wireName: 'Token')
  Token get token;

  @BuiltValueField(wireName: 'UserPerson')
  UserPerson get userPerson;

  @override
  Map<String, dynamic> toMap() => serializers.serializeWith(Session.serializer, this);

  static Session fromJson(Map<String, dynamic> map) => serializers.deserializeWith(Session.serializer, map);

  static Serializer<Session> get serializer => _$sessionSerializer;
}
