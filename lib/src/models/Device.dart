library device;

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:bunq/src/models/Id.dart';
import 'package:bunq/src/utils/model.dart';
import 'package:bunq/src/utils/serializers.dart';

part 'Device.g.dart';

abstract class Device with ModelInterface implements Built<Device, DeviceBuilder> {
  Device._();

  factory Device([Function(DeviceBuilder b) updates]) = _$Device;

  @BuiltValueField(wireName: 'Id')
  Id get id;

  @override
  Map<String, dynamic> toMap() => serializers.serializeWith(Device.serializer, this);

  static Device fromJson(Map<String, dynamic> map) => serializers.deserializeWith(Device.serializer, map);

  static Serializer<Device> get serializer => _$deviceSerializer;
}
