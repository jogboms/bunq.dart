library setting;

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:bunq/src/utils/model.dart';
import 'package:bunq/src/utils/serializers.dart';

part 'Setting.g.dart';

abstract class Setting with ModelInterface implements Built<Setting, SettingBuilder> {
  Setting._();

  factory Setting([Function(SettingBuilder b) updates]) = _$Setting;

  String get color;

  @BuiltValueField(wireName: 'default_avatar_status')
  String get defaultAvatarStatus;

  @nullable
  String get icon;

  @BuiltValueField(wireName: 'restriction_chat')
  String get restrictionChat;

  @override
  Map<String, dynamic> toMap() => serializers.serializeWith(Setting.serializer, this);

  static Setting fromJson(Map<String, dynamic> map) => serializers.deserializeWith(Setting.serializer, map);

  static Serializer<Setting> get serializer => _$settingSerializer;
}
