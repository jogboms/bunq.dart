library monetary_account_profile;

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:bunq/src/models/Money.dart';
import 'package:bunq/src/utils/model.dart';
import 'package:bunq/src/utils/serializers.dart';

part 'MonetaryAccountProfile.g.dart';

abstract class MonetaryAccountProfile
    with ModelInterface
    implements Built<MonetaryAccountProfile, MonetaryAccountProfileBuilder> {
  MonetaryAccountProfile._();

  factory MonetaryAccountProfile([Function(MonetaryAccountProfileBuilder b) updates]) = _$MonetaryAccountProfile;

  @BuiltValueField(wireName: 'profile_action_required')
  String get profileActionRequired;

  @BuiltValueField(wireName: 'profile_amount_required')
  Money get profileAmountRequired;

  @nullable
  @BuiltValueField(wireName: 'profile_drain')
  Object get profileDrain;

  @nullable
  @BuiltValueField(wireName: 'profile_fill')
  Object get profileFill;

  @override
  Map<String, dynamic> toMap() => serializers.serializeWith(MonetaryAccountProfile.serializer, this);

  static MonetaryAccountProfile fromJson(Map<String, dynamic> map) =>
      serializers.deserializeWith(MonetaryAccountProfile.serializer, map);

  static Serializer<MonetaryAccountProfile> get serializer => _$monetaryAccountProfileSerializer;
}
