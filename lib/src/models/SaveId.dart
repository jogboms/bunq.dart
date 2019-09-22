library save_id;

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:bunq/src/utils/model.dart';
import 'package:bunq/src/utils/serializers.dart';

part 'SaveId.g.dart';

abstract class SaveId with ModelInterface implements Built<SaveId, SaveIdBuilder> {
  SaveId._();

  factory SaveId([updates(SaveIdBuilder b)]) = _$SaveId;

  int get id;

  @override
  Map<String, dynamic> toMap() => serializers.serializeWith(SaveId.serializer, this);

  static SaveId fromJson(Map<String, dynamic> map) => serializers.deserializeWith(SaveId.serializer, map);

  static Serializer<SaveId> get serializer => _$saveIdSerializer;
}
