library document_attachment;

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:bunq/src/utils/model.dart';
import 'package:bunq/src/utils/serializers.dart';

part 'DocumentAttachment.g.dart';

abstract class DocumentAttachment with ModelInterface implements Built<DocumentAttachment, DocumentAttachmentBuilder> {
  DocumentAttachment._();

  factory DocumentAttachment([Function(DocumentAttachmentBuilder b) updates]) = _$DocumentAttachment;

  @BuiltValueField(wireName: 'content_type')
  String get contentType;

  String get description;

  int get id;

  @override
  Map<String, dynamic> toMap() => serializers.serializeWith(DocumentAttachment.serializer, this);

  static DocumentAttachment fromJson(Map<String, dynamic> map) =>
      serializers.deserializeWith(DocumentAttachment.serializer, map);

  static Serializer<DocumentAttachment> get serializer => _$documentAttachmentSerializer;
}
