library image;

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:bunq/src/utils/model.dart';
import 'package:bunq/src/utils/serializers.dart';

part 'Image.g.dart';

abstract class Image with ModelInterface implements Built<Image, ImageBuilder> {
  Image._();

  factory Image([Function(ImageBuilder b) updates]) = _$Image;

  @BuiltValueField(wireName: 'attachment_public_uuid')
  String get attachmentPublicUuid;

  @BuiltValueField(wireName: 'content_type')
  String get contentType;

  int get height;

  int get width;

  @override
  Map<String, dynamic> toMap() => serializers.serializeWith(Image.serializer, this);

  static Image fromJson(Map<String, dynamic> map) => serializers.deserializeWith(Image.serializer, map);

  static Serializer<Image> get serializer => _$imageSerializer;
}
