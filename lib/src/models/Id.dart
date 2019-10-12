library id;

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:bunq/src/utils/model.dart';
import 'package:bunq/src/utils/serializers.dart';

part 'Id.g.dart';

abstract class Id with ModelInterface implements Built<Id, IdBuilder> {
  Id._();

  factory Id([Function(IdBuilder b) updates]) = _$Id;

  int get id;

  @override
  Map<String, dynamic> toMap() => serializers.serializeWith(Id.serializer, this);

  static Id fromJson(Map<String, dynamic> map) => serializers.deserializeWith(Id.serializer, map);

  static Serializer<Id> get serializer => _$idSerializer;
}
