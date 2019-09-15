library notificationFilter;

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:bunq/src/utils/model.dart';
import 'package:bunq/src/utils/serializers.dart';

part 'NotificationFilter.g.dart';

abstract class NotificationFilter with ModelInterface implements Built<NotificationFilter, NotificationFilterBuilder> {
  NotificationFilter._();

  factory NotificationFilter([updates(NotificationFilterBuilder b)]) = _$NotificationFilter;

  String get category;

  @BuiltValueField(wireName: 'notification_delivery_method')
  String get notificationDeliveryMethod;

  @override
  Map<String, dynamic> toMap() => serializers.serializeWith(NotificationFilter.serializer, this);

  static NotificationFilter fromJson(Map<String, dynamic> map) =>
      serializers.deserializeWith(NotificationFilter.serializer, map);

  static Serializer<NotificationFilter> get serializer => _$notificationFilterSerializer;
}
