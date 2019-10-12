library billing_contract;

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:bunq/src/models/BillingContractSubscription.dart';
import 'package:bunq/src/utils/model.dart';
import 'package:bunq/src/utils/serializers.dart';

part 'BillingContract.g.dart';

abstract class BillingContract with ModelInterface implements Built<BillingContract, BillingContractBuilder> {
  BillingContract._();

  factory BillingContract([Function(BillingContractBuilder b) updates]) = _$BillingContract;

  @BuiltValueField(wireName: 'BillingContractSubscription')
  BillingContractSubscription get billingContractSubscription;

  @override
  Map<String, dynamic> toMap() => serializers.serializeWith(BillingContract.serializer, this);

  static BillingContract fromJson(Map<String, dynamic> map) =>
      serializers.deserializeWith(BillingContract.serializer, map);

  static Serializer<BillingContract> get serializer => _$billingContractSerializer;
}
