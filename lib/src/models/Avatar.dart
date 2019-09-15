library avatar;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:bunq/src/models/Image.dart';
import 'package:bunq/src/utils/model.dart';
import 'package:bunq/src/utils/serializers.dart';

part 'Avatar.g.dart';

abstract class Avatar with ModelInterface implements Built<Avatar, AvatarBuilder> {
  Avatar._();

  factory Avatar([updates(AvatarBuilder b)]) = _$Avatar;

  @BuiltValueField(wireName: 'anchor_uuid')
  String get anchorUuid;

  BuiltList<Image> get image;

  String get uuid;

  @override
  Map<String, dynamic> toMap() => serializers.serializeWith(Avatar.serializer, this);

  static Avatar fromJson(Map<String, dynamic> map) => serializers.deserializeWith(Avatar.serializer, map);

  static Serializer<Avatar> get serializer => _$avatarSerializer;
}
