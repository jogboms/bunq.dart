library address;

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:bunq/src/utils/model.dart';
import 'package:bunq/src/utils/serializers.dart';

part 'Address.g.dart';

abstract class Address with ModelInterface implements Built<Address, AddressBuilder> {
  Address._();

  factory Address([updates(AddressBuilder b)]) = _$Address;

  String get city;

  String get country;

  @nullable
  String get extra;

  @BuiltValueField(wireName: 'house_number')
  String get houseNumber;

  @nullable
  @BuiltValueField(wireName: 'mailbox_name')
  String get mailboxName;

  @nullable
  @BuiltValueField(wireName: 'postal_code')
  String get postalCode;

  @nullable
  String get province;

  @nullable
  String get street;

  @override
  Map<String, dynamic> toMap() => serializers.serializeWith(Address.serializer, this);

  static Address fromJson(Map<String, dynamic> map) => serializers.deserializeWith(Address.serializer, map);

  static Serializer<Address> get serializer => _$addressSerializer;
}
