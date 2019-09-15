library alias;

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:bunq/src/utils/model.dart';
import 'package:bunq/src/utils/serializers.dart';

part 'Alias.g.dart';

abstract class Alias with ModelInterface implements Built<Alias, AliasBuilder> {
  Alias._();

  factory Alias([updates(AliasBuilder b)]) = _$Alias;

  String get name;

  String get type;

  String get value;

  @override
  Map<String, dynamic> toMap() => serializers.serializeWith(Alias.serializer, this);

  static Alias fromJson(Map<String, dynamic> map) => serializers.deserializeWith(Alias.serializer, map);

  static Serializer<Alias> get serializer => _$aliasSerializer;
}
